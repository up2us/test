import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'U Calendat',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: MyHomePage(storage: Data('assets-list.csv')),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  DateTime current = DateTime.now();
  Map contentData = {};
  String _imgPath = '';
  String _txtPath = '';
  Map _txt = {};
  bool autoUpdate = true;

  DateTime getDate() {
    if (autoUpdate && current.day != DateTime.now().day) {
      enableAutoUpdate();
    }
    return current;
  }

  String getImgPath(queryKey) {
    print(queryKey);
    print(contentData);
    if (contentData.containsKey(queryKey)) {
      _imgPath = contentData[queryKey][0];
    } else {
      _imgPath = 'default/default.png';
    }
    notifyListeners();
    return _imgPath;
  }

  String getTxtPath(queryKey) {
    if (contentData.containsKey(queryKey)) {
      _txtPath = contentData[queryKey][1];
      notifyListeners();
    } else {
      _txtPath = 'default/default.txt';
    }
    return _txtPath;
  }

  void setTxt(queryKey) {
    List rawTxt = ['Hello', '你好！'];
    LineSplitter splitter = LineSplitter();
    Data(getTxtPath(queryKey)).readStrData().then((value) {
      rawTxt = splitter.convert(value);
      print('txtValue = $rawTxt');
      _txt = {'EN':rawTxt[0].trim(),'CH':rawTxt[1].trim()};
      notifyListeners();
    });
  }

  Map getTxt(queryKey) {
    setTxt(queryKey);
    return _txt;
  }

  void getNextDate() {
    autoUpdate = false;
    current = DateTime(current.year, current.month, current.day + 1);
    notifyListeners();
  }

  void getLastDate() {
    autoUpdate = false;
    current = DateTime(current.year, current.month, current.day - 1);
    notifyListeners();
  }

  void enableAutoUpdate() {
    autoUpdate = true;
    current = DateTime.now();
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.storage});

  final Data storage;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    final appState = Provider.of<MyAppState>(context, listen: false);
    widget.storage.readCsvData().then((value) {
      print('value = $value');
      appState.contentData = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(days: 1)),
        builder: (contxt, snapshot) {
          return Scaffold(
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var r = constraints.maxWidth / constraints.maxHeight;
                if (r > 4 / 3) {
                  return Center(
                    child: Column(
                      children: [
                        Expanded(flex: 1, child: Container(),),
                        Expanded(
                          flex: 10,
                          child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1),
                          ),
                            child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 23,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: DateSection(),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            width: constraints.maxWidth,
                                            child: ImageSection(),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 12,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                      Expanded(
                                        flex: 38,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: EnTextSection(),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: ChTextSection(),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              LastDate(),
                              AutoUpdate(),
                              NextDate(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container()),
                          Expanded(
                            flex: 10,
                            child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),),
                            child: AspectRatio(
                                aspectRatio: 3 / 4,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 18,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 63,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 378,
                                          child: DateSection(),
                                        ),
                                        Expanded(
                                          flex: 63,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 672,
                                          child: ImageSection(),
                                        ),
                                        Expanded(
                                          flex: 96,
                                          child: EnTextSection(),
                                        ),
                                        Expanded(
                                          flex: 48,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 96,
                                          child: ChTextSection(),
                                        ),
                                        Expanded(
                                          flex: 96,
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                ],
                              )),
                          ),),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                LastDate(),
                                AutoUpdate(),
                                NextDate(),
                              ],
                            ),
                          ),
                    ],
                  ));
                }
              },
            ),
          );
        });
  }
}

class DateSection extends StatelessWidget {
  const DateSection({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Color dateColor = Color(0xFF000000);

    switch (appState.current.weekday) {
      case DateTime.saturday:
        dateColor = Color(0xFF7AE582);
        break;
      case DateTime.sunday:
        dateColor = Color(0xFFFF5757);
        break;
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 4,
            child: FittedBox(
              child: Text(
                DateFormat('MMM').format(appState.getDate()),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: FittedBox(
              child: Text(
                DateFormat('d').format(appState.getDate()),
                style: TextStyle(fontWeight: FontWeight.bold, color: dateColor),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FittedBox(
              child: Text(
                DateFormat('E').format(appState.getDate()),
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Container(
      child: Image.asset(
        appState.getImgPath(DateFormat('yyyy/M/d').format(appState.getDate())),
        fit: BoxFit.contain,
      ),
    );
  }
}

class EnTextSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Container(
      child: FittedBox(
        child: Text(
          appState.getTxt(DateFormat('yyyy/M/d').format(appState.getDate()))['EN'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ChTextSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Container(
      child: FittedBox(
        child: Text(
          appState.getTxt(DateFormat('yyyy/M/d').format(appState.getDate()))['CH'],
          style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class LastDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return FloatingActionButton.extended(
      onPressed: () {
        appState.getLastDate();
      },
      label: const Text('Last'),
      icon: const Icon(Icons.arrow_left),
    );
  }
}

class NextDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return FloatingActionButton.extended(
      onPressed: () {
        appState.getNextDate();
      },
      icon: const Icon(Icons.arrow_right),
      label: const Text('Next'),
    );
  }
}

class AutoUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return FloatingActionButton.extended(
      onPressed: () {
        appState.enableAutoUpdate();
      },
      label: const Text('Auto'),
      icon: const Icon(Icons.sync),
    );
  }
}

class Data {
  String filePath;

  Data(this.filePath);

  Future<String> readStrData() async {
    print('file path = $filePath');
    try {
      String rawData = await rootBundle.loadString(filePath);

      return rawData;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  Future<Map> readCsvData() async {
    print('file path = $filePath');
    try {
      final rawData = await rootBundle.loadString(filePath);
      // Read the file

      List<List<dynamic>> listData = const CsvToListConverter(eol: "\n").convert(rawData);
      listData.removeAt(0);
      Map data = { for (var item in listData) item[0].trim() : [item[1].trim(), item[2].trim()]};

      return data;
    } catch (e) {
      // If encountering an error, return 0
      return {};
    }
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  DateTime current = DateTime.now();
  bool autoUpdate = true;
  
  DateTime getDate() {
    if (autoUpdate && current.day != DateTime.now().day) {
      enableAutoUpdate();
    }
    return current;
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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(minutes: 1)),
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
                DateFormat('dd').format(appState.getDate()),
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
    const list = [
      'create/img_0609.png',
      'create/img_0610.png',
      'create/img_0611.png',
      'create/img_0612.png',
    ];
    var appState = context.watch<MyAppState>();

    return Container(
      child: Image.asset(
        list[appState.current.day % list.length],
        fit: BoxFit.contain,
      ),
    );
  }
}

class EnTextSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const list = [
      'Spoken words are more powerful than you think',
      'To live but not just to exist',
      'Why not find some time to be kind to yourself',
      'work for life, not work',
    ];
    var appState = context.watch<MyAppState>();

    return Container(
      child: FittedBox(
        child: Text(
          list[appState.current.day % list.length],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ChTextSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const list = [
      '說出的話語比你想像的更有力量',
      '要活著，而不僅僅只是存在',
      '何不找些時間善待自己',
      '為人生而工作，而非只是工作',
    ];
    var appState = context.watch<MyAppState>();

    return Container(
      child: FittedBox(
        child: Text(list[appState.current.day % list.length],
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

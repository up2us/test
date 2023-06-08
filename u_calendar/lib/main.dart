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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        ),
        home: MyHomePage(),
      ),
    );  
  }
}

class MyAppState extends ChangeNotifier {
  DateTime current = DateTime.now();

  DateTime getDate(){
    current = DateTime.now();
    notifyListeners();
    return current;
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(microseconds: 500000)),
      builder: (contxt, snapshot) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              var r = constraints.maxWidth/constraints.maxHeight;
              if (r > 4/3) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16/9,  
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
                );
              }
              else {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                    ),
                    child: AspectRatio(
                      aspectRatio: 3/4,
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
                      )
                    ),
                  )
                );
              }
            },
          ),
        );
      }
    );
  }
}

class DateSection extends StatelessWidget {
  const DateSection({super.key});

  @override
  Widget build(BuildContext context) { 
    var appState = context.watch<MyAppState>();

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
            child: FittedBox(child: Text(DateFormat('MMM').format(appState.getDate()),),),
          ),
          Expanded(
            flex: 10, 
            child: FittedBox(
              child: Text(
                DateFormat('dd').format(DateTime.now()),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FittedBox(
              child: Text(
                DateFormat('E').format(appState.getDate()),
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              child: Text(
                DateFormat('hh:mm:ss').format(appState.getDate()),
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
          Expanded(
            flex: 1,
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
      'https://media.istockphoto.com/id/1178017061/photo/woolly-mammoth-set-in-a-winter-scene-environment-16-9-panoramic-format.jpg?s=612x612&w=0&k=20&c=nYVvqx3LSYZjVjCCpb9qlVdnYXbb47jPAmEdW-Cf7VM=',
      'https://images.unsplash.com/photo-1580757468214-c73f7062a5cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8MTYlM0E5fGVufDB8fDB8fHww&w=1000&q=80',
      'https://images.unsplash.com/photo-1558637845-c8b7ead71a3e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8MTYlM0E5fGVufDB8fDB8fHww&w=1000&q=80'
    ];
    var appState = context.watch<MyAppState>();

    return Container(
      child: Image.network(
        list[appState.current.second % list.length],
        fit: BoxFit.contain,
      ),
    );
  }
}

class EnTextSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        child: Text(
          'How much did they pay you to give up on your dreams?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),          
      ),
    );
  }
}

class ChTextSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        child: Text(
          '他們付了你多少錢，讓你放棄了你的夢想？',
          style: TextStyle(color: Colors.grey)
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

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
  bool autoUpdate = true;
  Map contentData = {
      "default": [
          "default/default.png",
          "Time travling ...",
          "時空旅行中"
      ],
      "2023/7/24": [
          "movie/Apollo-13_01.jpg",
          "Houston, we have a problem.",
          "休斯頓，我們有麻煩了"
      ],
      "2023/7/25": [
          "create/believe-you-can-and-you're-halfway-there.png",
          "Believe you can and you're halfway there.",
          "相信自己可以，你就已經成功了一半"
      ],
      "2023/7/26": [
          "movie/Forrest-Gump_01.jpg",
          "Life was like a box of chocolates. You never know what you're gonna get.",
          "人生就像一盒巧克力，你永遠不知道會吃到什麼口味"
      ],
      "2023/7/27": [
          "create/education-is-the-most-powerful-weapon-which-you-can-use-to-change-the-world.png",
          "Education is the most powerful weapon which you can use to change the world.",
          "教育是你可以用來改變世界的最有力武器"
      ],
      "2023/7/28": [
          "movie/Good-Will-Hunting_01.png",
          "It’s not your fault.",
          "這不是你的錯"
      ],
      "2023/7/29": [
          "create/spoken-words-are-more-powerful-than-you-think.png",
          "Spoken words are more powerful than you think.",
          "說出的話語比你想像的更有力量"
      ],
      "2023/7/30": [
          "movie/Jerry-Maguire_01.jpg",
          "You complete me.",
          "你完整了我的人生"
      ],
      "2023/7/31": [
          "create/the-journey-of-a-thousand-miles-begins-with-a-single-step.png",
          "The journey of a thousand miles begins with a single step.",
          "千里之行，始於足下"
      ],
      "2023/8/1": [
          "movie/Star-Wars_01.jpg",
          "May the Force be with you.",
          "願原力與你同在"
      ],
      "2023/8/2": [
          "create/the-only-true-wisdom-is-in-knowing-you-know-nothing.png",
          "The only true wisdom is in knowing you know nothing.",
          "真正的智慧就在於知道自己一無所知"
      ],
      "2023/8/3": [
          "movie/The-Shawshank-Redemption_01.jpg",
          "Fear can hold you prisoner. Hope can set you free.",
          "恐懼囚禁你，希望讓你自由"
      ],
      "2023/8/4": [
          "create/the-only-way-to-do-great-work-is-to-love-what-you-do.png",
          "The only way to do great work is to love what you do.",
          "做出卓越工作的唯一方式，就是熱愛所做之事"
      ],
      "2023/8/5": [
          "movie/The-Terminator_01.jpg",
          "I'll be back.",
          "我會回來的"
      ],
      "2023/8/6": [
          "create/to-live-but-not-just-to-exist.png",
          "To live but not just to exist.",
          "要活著，而不僅僅只是存在"
      ],
      "2023/8/7": [
          "movie/Titanic_01.jpg",
          "I'll never let go.",
          "我永遠不會放手"
      ],
      "2023/8/8": [
          "create/where-there-is-hope-there-is-life.png",
          "Where there is hope, there is life.",
          "有希望存在的地方，就有生命"
      ],
      "2023/8/9": [
          "movie/Toy-Story-3_01.jpg",
          "Don’t cry because it’s over; smile because it happened.",
          "別因為結束而哭泣，要因為曾經發生而微笑"
      ],
      "2023/8/10": [
          "create/why-not-find-some-time-to-be-kind-to-yourself.png",
          "Why not find some time to be kind to yourself?",
          "何不找些時間善待自己"
      ],
      "2023/8/11": [
          "movie/Up-In-The-Air_01.jpg",
          "How much did they pay you to give up on your dreams?",
          "他們付了你多少錢，讓你放棄了你的夢想？"
      ],
      "2023/8/12": [
          "create/work-for-life-not-work.png",
          "Work for life, not work.",
          "為人生而工作，而非只是工作"
      ],
  };

  DateTime getDate() {
    if (autoUpdate && current.day != DateTime.now().day) {
      enableAutoUpdate();
    }
    return current;
  }

  List getContent(queryDate) {
    String queryKey = DateFormat('yyyy/M/d').format(queryDate);
    if (contentData.containsKey(queryKey)) {
      return contentData[queryKey];
    } else {
      return contentData["default"];
    }
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
                      Expanded(
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
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    children: [
                      Expanded(
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
                          )
                        ),
                      ),
                    ],
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
        appState.getContent(appState.getDate())[0],
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
          appState.getContent(appState.getDate())[1],
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
          appState.getContent(appState.getDate())[2],
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

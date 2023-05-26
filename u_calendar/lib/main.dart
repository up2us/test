import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'U Calendat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            var r = constraints.maxWidth/constraints.maxHeight;

            if (r > 4/3) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: constraints.maxWidth,
                            child: dateSection
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(child: Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: landscapeContentSection,
                        ),
                      ],
                    ),),
                  ),
                ],
              );
            }
            else {
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: dateSection,
                        ),
                        Flexible(
                          flex: 2,
                          child: portionContentSection,
                        ),
                      ]
                    )
                  ),
                ],
              );
            }
          },
        ),
      ),
    );  
  }
}

Widget dateSection = Container(
  color: Colors.white,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        flex: 4,
        child: FittedBox(
          child: Text(
            'MAY',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),  
      ),
      Expanded(
        flex: 9, 
        child: FittedBox(
          child: Text(
            '31',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Expanded(
        flex: 4,
        child: FittedBox(child: Text('Wed'),),
      ),         
    ],
  ),  
);

Widget landscapeContentSection = Column(
  children: [
    Expanded(
      flex: 2,
      child: imageSection
    ),
    Expanded(
      flex: 1,
      child: textSection
    ),
  ],
);

Widget portionContentSection = Column(
  children: [
    Expanded(
      flex: 2,
      child: imageSection
    ),
    Expanded(
      flex: 1,
      child: textSection
    ),
  ],
);

Widget imageSection = Container(
  color: Colors.white,
  child: Image.network(
    'https://media.istockphoto.com/id/1178017061/photo/woolly-mammoth-set-in-a-winter-scene-environment-16-9-panoramic-format.jpg?s=612x612&w=0&k=20&c=nYVvqx3LSYZjVjCCpb9qlVdnYXbb47jPAmEdW-Cf7VM=',
    fit: BoxFit.contain,
  ),
);

Widget textSection = Container(
  color: Colors.white,
  child: Column(
    children: [
      Expanded(
        flex: 1,
        child: FittedBox(
          child: Text(
            'How much did they pay you to give up on your dreams?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),          
        ),
      ),
      Expanded(
        flex: 1,
        child: FittedBox(
          child: Text(
            '他們付了你多少錢，讓你放棄了你的夢想？',
            style: TextStyle(color: Colors.black.withOpacity(0.6))
          ),
        ),
      ),
    ],
  ),
);

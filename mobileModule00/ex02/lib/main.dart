import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final List <String> Lista = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', 'AC', 'C', '=', '+', '-', '*', '/'];
const Color myColor = Color(0xFF8F00FF);
class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme baseScheme = ColorScheme.fromSeed(seedColor: myColor, brightness: Brightness.light);
    final ColorScheme scheme = baseScheme.copyWith(primary: myColor, onPrimary: Colors.white);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: scheme,
        primaryColor: myColor,
        appBarTheme: AppBarTheme(backgroundColor: scheme.primary, foregroundColor: scheme.onPrimary)
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget
{
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: cs.primary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: '0'),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 28, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: '0'),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 28, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),

                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: LayoutBuilder(

              builder: (context, constraints) {

                final height = constraints.maxHeight;
                final width = constraints.maxWidth;
                const crossAxisCount = 5;
                final rowCount = (Lista.length / crossAxisCount).ceil();
                final buttonHeight = height / rowCount;
                final buttonWidth = width / crossAxisCount;
                final aspectRatio = buttonWidth / buttonHeight;

                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 1,
                    vertical: 1,
                  ),
                  child: GridView.count(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: aspectRatio,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(Lista.length, (index) {
                      return ElevatedButton(
                        onPressed: () {
                          print('button pressed ${Lista[index]}');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myColor,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 22),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(Lista[index]),
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
          ),
        ],
      ),


    );
  }
}

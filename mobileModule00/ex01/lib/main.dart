import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String containerText = 'A simple text';

  void changeText() {
    setState(() {
      containerText = containerText == 'A simple text' ? 'Hello World!' : 'A simple text';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                containerText, // Usa a variável de estado aqui
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: changeText, // Chama a função changeText quando pressionado
              child: const Text('Click me'),
            ),
          ],
        ),
      ),
    );
  }
}
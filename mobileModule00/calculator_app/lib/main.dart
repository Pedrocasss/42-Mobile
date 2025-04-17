import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

final List <String> Lista = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', 'AC', 'C', '=', '+', '-', '*', '/'];
const Color myColor = Color(0xFF8F00FF);

String _evaluateExpression(String exp) {
  try {
    final parser = ShuntingYardParser();
    final expression = parser.parse(exp);
    final context = ContextModel();
    final result = expression.evaluate(EvaluationType.REAL, context);
    return result.toString();
  } catch (e) {
    print("Erro: {$e}");
    return 'Erro';
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme baseScheme = ColorScheme.fromSeed(seedColor: myColor, brightness: Brightness.light);
    final ColorScheme scheme = baseScheme.copyWith(primary: myColor, onPrimary: Colors.white);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: scheme,
        primaryColor: myColor,
        appBarTheme: AppBarTheme(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
        ),
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _expressionController = TextEditingController(text: '0');
  final TextEditingController _resultController = TextEditingController(text: '0');
  String expression = '';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: cs.primary,
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
                    controller: _expressionController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 28, color: Colors.black),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    controller: _resultController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 28, color: Colors.black),
                    decoration: const InputDecoration(
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  child: GridView.count(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: aspectRatio,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(Lista.length, (index) {
                      return ElevatedButton(
                        onPressed: () {
                          final value = Lista[index];
                          print("Button pressed $value");
                          setState(() {
                            if (value == 'AC') {
                              expression = '';
                              _expressionController.text = '0';
                              _resultController.text = '0';
                            } else if (value == 'C') {
                              if (expression.isNotEmpty) {
                                expression = expression.substring(0, expression.length - 1);
                                _expressionController.text = expression.isEmpty ? '0' : expression;
                              }
                            }
                            else if (value == '=') {
                              final exp = expression
                                  .replaceAll('×', '*')
                                  .replaceAll('÷', '/');
                              _resultController.text =
                                  _evaluateExpression(exp);
                            } else {
                              expression += value;
                              _expressionController.text = expression;
                            }
                          });
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
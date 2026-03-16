import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple calculator',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculaterScreenState();
}

class _CalculaterScreenState extends State<CalculatorScreen> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();

  double result = 0;

  void calculate(String operation) {
    double n1 = double.tryParse(num1Controller.text) ?? 0;
    double n2 = double.tryParse(num2Controller.text) ?? 0;

    setState(() {
      switch (operation) {
        case '+':
          result = n1 + n2;
          break;
        case '-':
          result = n1 - n2;
          break;
        case '*':
          result = n1 * n2;
          break;
        case '/':
          result = n1 != 0 ? n1 / n2 : 0;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Simple Calculator",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: num1Controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "First Number",
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: TextField(
                    controller: num2Controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Second Number",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              "Result: $result",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 25,
                childAspectRatio: 3,
                children: [
                  ElevatedButton(
                    onPressed: () => calculate('+'),
                    child: Text("+", style: TextStyle(fontSize: 24)),
                  ),
                  ElevatedButton(
                    onPressed: () => calculate('-'),
                    child: Text("-", style: TextStyle(fontSize: 24)),
                  ),
                  ElevatedButton(
                    onPressed: () => calculate('*'),
                    child: Text("X", style: TextStyle(fontSize: 24)),
                  ),
                  ElevatedButton(
                    onPressed: () => calculate('/'),
                    child: Text("÷", style: TextStyle(fontSize: 24)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

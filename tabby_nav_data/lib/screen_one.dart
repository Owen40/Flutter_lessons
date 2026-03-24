import 'package:flutter/material.dart';
import 'display.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation Application"),
        backgroundColor: Colors.limeAccent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text(
              "Enter Your Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                String age = _ageController.text;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisplayScreen(name: name, age: age),
                  ),
                );
              },
              child: Text("Next Screen"),
            ),
          ],
        ),
      ),
    );
  }
}

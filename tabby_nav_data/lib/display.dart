import 'package:flutter/material.dart';

class DisplayScreen extends StatelessWidget {
  final String name;
  final String age;

  const DisplayScreen({super.key, required this.name, required this.age});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name: $name', style: TextStyle(fontSize: 24)),
              Text('Age: $age', style: TextStyle(fontSize: 24)),
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Go back"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

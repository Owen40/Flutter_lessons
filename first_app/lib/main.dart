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
      title: 'My First App',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.green)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Basics',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        // centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Typography',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text('My Second text', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(Icons.home, size: 30, color: Colors.blue),
                SizedBox(width: 10),
                Icon(Icons.favorite, size: 40, color: Colors.red),
                SizedBox(width: 10),
                Icon(Icons.settings, size: 35, color: Colors.green),
              ],
            ),
            const SizedBox(height: 25),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Outlined textField',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            const SizedBox(height: 10),
            const Text(
              'Email Address',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'john.doe@email.com',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: Icon(Icons.visibility),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Button Pressed')));
                // print('Button pressed!');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
              ),
              child: const Text('Click me'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pressed the custom button')),
                );
                // print('Button pressed!');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Click me', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

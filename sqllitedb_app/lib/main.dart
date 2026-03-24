import 'package:flutter/material.dart';
import 'db_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: PersonScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PersonScreen extends StatefulWidget {
  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  List<Map<String, dynamic>> people = [];

  void loadPeople() async {
    final data = await DbHelper.instance.getPeople();
    setState(() {
      people = data;
    });
  }

  void addPerson() async {
    await DbHelper.instance.insertPerson({
      'name': nameController.text,
      'age': int.parse(ageController.text),
    });

    nameController.clear();
    ageController.clear();

    loadPeople();
  }

  @override
  void initState() {
    super.initState();
    loadPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DBSQLLITE Example")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Age"),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: addPerson, child: Text("Add Person")),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(people[index]['name']),
                    subtitle: Text("Age: ${people[index]['age']}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

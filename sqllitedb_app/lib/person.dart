class Person {
  int? id;
  String name;
  int age;

  Person({this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(id: map['id'], name: map['name'], age: map['age']);
  }
}

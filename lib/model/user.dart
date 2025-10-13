class User {
  final String name;
  final String age;
  int? id;

  User({required this.name, required this.age, this.id});

  Map<String, dynamic> toMap() {
    return {'name': name, 'age': age};
  }

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
      name: map['name'] as String,
      age: map['age'] as String,
      id: map['id'],
    );
  }
}

import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
  });

  factory User.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      type: json['type'],
      token: json['token'],
    );
  }

  String toJson() {
    final Map<String, dynamic> json = {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
    };
    return jsonEncode(json);
  }
}

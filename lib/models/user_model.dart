// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  final List<dynamic> cart;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.address,
      required this.type,
      required this.token,
      required this.cart});

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
        cart: List<Map<String, dynamic>>.from(
            json['cart']?.map((x) => Map<String, dynamic>.from(x))));
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

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id:id ?? this.id,
      name: name?? this.name,
      email:email ?? this.email,
      password:password ?? this.password,
      address:address ?? this.address,
      type:type ?? this.type,
      token: token?? this.token,
      cart:cart ?? this.cart,
    );
  }
}

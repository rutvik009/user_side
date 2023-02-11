import 'dart:convert';

class User {
  final bool success;
  final String token;

  const User({required this.success, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      success: json['success'],
      token: json['token'],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String role;
  final String avatarUrl;

  UserModel({
    required this.email,
    required this.role,
    required this.userId,
    required this.name,
    required this.avatarUrl,
  });

  factory UserModel.fromJwtAndJson(
    Map<String, dynamic> tokenData,
    Map<String, dynamic> jsonData,
  ) {
    return UserModel(
      email: tokenData["email"],
      userId: tokenData["userId"],
      name: tokenData['sub'],
      role: tokenData["roles"][0],
      avatarUrl: jsonData["avatarUrl"],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'role': role,
      'avatarUrl': avatarUrl,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      avatarUrl: map['avatarUrl'] as String,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

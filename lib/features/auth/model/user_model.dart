import 'dart:convert';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String role;

  UserModel({
    required this.email,
    required this.role,
    required this.userId,
    required this.name,
  });

  factory UserModel.fromJwt(Map<String, dynamic> tokenData) {
    return UserModel(
      email: tokenData["email"],
      userId: tokenData["userId"],
      name: tokenData['sub'],
      role: tokenData["roles"][0],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'sub': name,
      'roles': role,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      name: map['sub'] as String,
      role: map['roles'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

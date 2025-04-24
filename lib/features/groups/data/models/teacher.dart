class Teacher {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  const Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
    );
  }

  
}

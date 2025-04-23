class Member {
  final String memberName;
  final String memberEmail;

  Member({required this.memberName, required this.memberEmail});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberName: json['memberName'],
      memberEmail: json['memberEmail'],
    );
  }
}

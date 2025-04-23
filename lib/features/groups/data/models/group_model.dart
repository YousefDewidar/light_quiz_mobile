import 'package:light_quiz/features/groups/data/models/member.dart';

class GroupModel {
  final String groupId;
  final String shortCode;
  final String name;
  final List<Member> members;

  GroupModel({
    required this.groupId,
    required this.shortCode,
    required this.name,
    required this.members,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      groupId: json['groupId'],
      shortCode: json['shortCode'],
      name: json['name'],
      members:
          (json['members'] as List)
              .map((member) => Member.fromJson(member))
              .toList(),
    );
  }
}

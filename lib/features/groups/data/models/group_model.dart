import 'package:light_quiz/features/groups/data/models/member.dart';
import 'package:light_quiz/features/groups/data/models/teacher.dart';

class GroupModel {
  final String groupId;
  final String shortCode;
  final String name;
  final List<Member> members;
  final Teacher teacher;

  GroupModel({
    required this.teacher,
    required this.groupId,
    required this.shortCode,
    required this.name,
    required this.members,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      teacher: Teacher.fromJson(json['teacher']),
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

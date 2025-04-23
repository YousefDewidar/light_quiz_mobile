import 'package:light_quiz/features/groups/data/models/group_model.dart';

abstract class GroupState {}

final class GroupInitial extends GroupState {}

final class GroupSuccess extends GroupState {
  final List<GroupModel> groups;

  GroupSuccess(this.groups);
}

final class GroupLoading extends GroupState {}

final class GroupFail extends GroupState {
  final String errMessage;

  GroupFail(this.errMessage);
}

final class JoinGroupSuccess extends GroupState {}

final class JoinGroupFailure extends GroupState {
  final String errMessage;

  JoinGroupFailure(this.errMessage);
}

final class LeaveGroupSuccess extends GroupState {}

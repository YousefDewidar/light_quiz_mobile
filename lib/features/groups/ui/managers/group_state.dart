import 'package:light_quiz/features/groups/data/models/group_model.dart';
import 'package:light_quiz/features/groups/data/models/quiz_group_metadata.dart';

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

final class GetQuizesOfGroupSuccess extends GroupState {
  final List<QuizGroupMetaData> quizzes;

  GetQuizesOfGroupSuccess(this.quizzes);
}

final class GetQuizesOfGroupFailure extends GroupState {
  final String errMessage;

  GetQuizesOfGroupFailure(this.errMessage);
}

final class GetQuizesOfGroupLoading extends GroupState {}

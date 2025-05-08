import 'package:dartz/dartz.dart';
import 'package:light_quiz/core/helper/failure.dart';
import 'package:light_quiz/features/groups/data/models/group_model.dart';
import 'package:light_quiz/features/groups/data/models/quiz_group_metadata.dart';

abstract class GroupRepo {
  Future<Either<Failure, List<GroupModel>>> getAllGroups();
  Future<Either<Failure, List<QuizGroupMetaData>>> getQuizesOfGroup({
    required String shortCode,
  });
  Future<Either<Failure, void>> joinGroup({required String shortCode});
  Future<Either<Failure, void>> leaveGroup({required String shortCode});
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:light_quiz/core/helper/api_service.dart';
import 'package:light_quiz/core/helper/failure.dart';
import 'package:light_quiz/features/groups/data/models/group_model.dart';
import 'package:light_quiz/features/groups/data/repo/group_repo.dart';

class GroupRepoImpl implements GroupRepo {
  ApiService apiService;
  GroupRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<GroupModel>>> getAllGroups() async {
    try {
      final res = await apiService.getWithToken("/api/group/memberof");
      List<GroupModel> groupsList = [];
      for (var group in res.data as List) {
        groupsList.add(GroupModel.fromJson(group));
      }
      return Right(groupsList);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> joinGroup({required String shortCode}) async {
    try {
      await apiService.postWithToken("/api/group/join/$shortCode", {});
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> leaveGroup({required String shortCode}) async {
    try {
      await apiService.postWithToken("/api/group/leave/$shortCode", {});
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}

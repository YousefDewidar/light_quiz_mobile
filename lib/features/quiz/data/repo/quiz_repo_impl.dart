import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:light_quiz/core/helper/api_service.dart';
import 'package:light_quiz/core/helper/failure.dart';
import 'package:light_quiz/core/helper/user_data.dart';
import 'package:light_quiz/features/quiz/data/models/quiz.dart';
import 'package:light_quiz/features/quiz/data/models/quiz_meta_data.dart';
import 'package:light_quiz/features/quiz/data/models/result.dart';
import 'package:light_quiz/features/quiz/data/models/submit_quiz_model.dart';
import 'package:light_quiz/features/quiz/data/repo/quiz_repo.dart';

class QuizRepoImpl implements QuizRepo {
  ApiService apiService;

  QuizRepoImpl(this.apiService);

  @override
  Future<Either<Failure, QuizMetaData>> getQuizMetaData({
    required String shortCode,
  }) async {
    try {
      final res = await apiService.getWithToken(
        "/api/quiz/metadata/$shortCode",
      );
      final quizMetaData = QuizMetaData.fromJson(
        res.data as Map<String, dynamic>,
      );
      return Right(quizMetaData);
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 404) {
          return Left(ServerFailure(errMessage: "Enter a valid code"));
        }
        if (e.response?.statusCode == 400) {
          return Left(
            ServerFailure(
              errMessage: "You have already taken this quiz before",
            ),
          );
        }

        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Quiz>> startAndGetQuiz({
    required String quizId,
  }) async {
    try {
      final res = await apiService.postWithToken("/api/quiz/start/$quizId", {});
      return Right(Quiz.fromJson(res.data as Map<String, dynamic>));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> submitQuiz({
    required SubmitQuizModel submitQuizModel,
  }) async {
    try {
      await apiService.postWithToken(
        "/api/student/submit/${submitQuizModel.quizId}",
        submitQuizModel.copyWith(studentId: getUserData()!.userId).toJson(),
      );
      return Right(null);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(errMessage: "There is an error"));
    }
  }

  @override
  Future<Either<Failure, Result>> getResults({required String quizId}) async {
    try {
      final res = await apiService.getWithToken("/api/student/result/$quizId");
      log(res.data.toString());
      return Right(Result.fromMap(res.data));
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 404) {
          return Left(ServerFailure(errMessage: "There is no result"));
        }
        return Left(ServerFailure.fromDioError(e));
      }

      return Left(ServerFailure(errMessage: "There is an error"));
    }
  }

  @override
  Future<Either<Failure, List<Result>>> getAllResults() async {
    try {
      final res = await apiService.getWithToken("/api/student/results");
      List<Result> resultsList = [];
      for (var result in res.data as List) {
        resultsList.add(Result.fromMap(result));
      }
      return Right(resultsList);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }

      return Left(ServerFailure(errMessage: "There is an error"));
    }
  }
}

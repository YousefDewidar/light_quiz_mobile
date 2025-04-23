import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:light_quiz/core/helper/api_service.dart';
import 'package:light_quiz/core/helper/di.dart';
import 'package:light_quiz/core/helper/failure.dart';
import 'package:light_quiz/features/auth/domain/repo/auth_repo.dart';
import 'package:light_quiz/features/auth/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;

  AuthRepoImpl(this.apiService);

  @override
  Future<Either<Failure, void>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final res = await apiService.post("/api/auth/token", {
        "email": email,
        "password": password,
      });
      final token = res.data["token"];
      final prefs = getIt.get<SharedPreferences>();
      log(token);
      prefs.setString("token", token);
      setUserData();

      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await apiService.post("/api/auth/register", {
        "email": email,
        "password": password,
        "fullName": name,
        "userType": "student",
      });
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  void signOut() {
    getIt.get<SharedPreferences>().remove("token");
  }

  void setUserData() async {
    final prefs = getIt.get<SharedPreferences>();
    String? token = prefs.getString('token');
    if (token != null) {
      try {
        final getData = await apiService.getWithToken('/api/auth/me');
        Map<String, dynamic> tokenData = JwtDecoder.decode(token);
        UserModel user = UserModel.fromJwtAndJson(tokenData, getData.data);
        prefs.setString('user', user.toJson());
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }
}

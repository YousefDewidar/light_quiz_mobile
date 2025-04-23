import 'package:dartz/dartz.dart';
import 'package:light_quiz/core/helper/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> signup({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Failure, void>> signIn({
    required String email,
    required String password,
  });

  void signOut();


}

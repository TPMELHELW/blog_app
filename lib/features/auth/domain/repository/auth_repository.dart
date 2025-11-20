import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUp(UserModel user);
  Future<Either<Failure, User>> signIn(UserModel user);
  Future<Either<Failure, User>> getCurrentUser();
}

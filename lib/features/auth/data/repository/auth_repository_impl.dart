import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:blog_app/features/auth/data/source/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, User>> signUp(UserModel user) async {
    return await authRemoteDataSource.signUp(user);
  }

  @override
  Future<Either<Failure, User>> signIn(UserModel user) async {
    return await authRemoteDataSource.signIn(user);
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final data = await authRemoteDataSource.getCurrentUser();
      if (data != null) {
        return Right(data);
      }
      return Left(Failure('No current user found'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUser;
  Future<Either<Failure, UserModel>> signIn(UserModel user);
  Future<Either<Failure, UserModel>> signUp(UserModel user);
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<Either<Failure, UserModel>> signIn(UserModel user) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: user.password!,
        email: user.email,
      );

      if (response.user == null) {
        return Left(Failure('User is null'));
      }

      return Right(UserModel.fromJson(response.user!.toJson()));
    } on AuthException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUp(UserModel user) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: user.password!,
        email: user.email,
        data: {'name': user.name},
      );

      if (response.user == null) {
        return Left(Failure('User is null'));
      }

      return Right(UserModel.fromJson(response.user!.toJson()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Session? get currentUser => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (currentUser != null) {
        final data = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUser!.user.id);
        return UserModel.fromJson(data.first);
      }

      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

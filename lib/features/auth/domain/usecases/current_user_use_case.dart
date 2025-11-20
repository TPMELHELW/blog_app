import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class CurrentUserUseCase implements UseCase<Either<Failure, User>, NoParams> {
  final AuthRepository authRepository;

  CurrentUserUseCase({required this.authRepository});
  @override
  Future<Either<Failure, User>> call({NoParams? params}) async {
    return await authRepository.getCurrentUser();
  }
}

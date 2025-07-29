import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements Usecase<UserEntity, UserSignInParameters> {
  final AuthRepository authRepository;
  UserSignIn(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(
    UserSignInParameters userSignInParameters,
  ) async {
    return await authRepository.loginWithEmailAndPassword(
      email: userSignInParameters.email,
      password: userSignInParameters.password,
    );
  }
}

class UserSignInParameters {
  final String email;

  final String password;

  UserSignInParameters({required this.email, required this.password});
}

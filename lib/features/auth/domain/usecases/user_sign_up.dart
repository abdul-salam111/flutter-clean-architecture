import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecase<String, UserSignUpParameters> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(
    UserSignUpParameters userSignUpParameters,
  ) async {
    return await authRepository.signupWithEmailAndPassword(
      email: userSignUpParameters.email,
      name: userSignUpParameters.name,
      password: userSignUpParameters.password,
    );
  }
}

class UserSignUpParameters {
  final String email;
  final String name;
  final String password;

  UserSignUpParameters({
    required this.email,
    required this.name,
    required this.password,
  });
}

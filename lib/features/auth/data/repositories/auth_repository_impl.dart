import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImpl(this.authRemoteDatasource);
  @override
  Future<Either<Failure, String>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signupWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final userId = await authRemoteDatasource.signupWithEmailAndPassword(
        email: email,
        name: name,
        password: password,
      );
      return right(userId);
    } on ServerExceptions catch (error) {
      return left(Failure(error.message));
    }
  }
}

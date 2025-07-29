import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImpl(this.authRemoteDatasource);
  @override
  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDatasource.signinWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on ServerExceptions catch (error) {
      return left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signupWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDatasource.signupWithEmailAndPassword(
        email: email,
        name: name,
        password: password,
      ),
    );
  }

  Future<Either<Failure, UserEntity>> _getUser(
    Future<UserEntity> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on AuthException catch (error) {
      return left(Failure(error.message));
    } on ServerExceptions catch (error) {
      return left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUserData() async {
    try {
      final user=await authRemoteDatasource.getCurrentUserData();
      if(user!=null){
        return right(user);
      }
      else{
        return left(Failure("User not logged in"));
      }
    } on ServerExceptions catch (error) {
      return left(Failure(error.message));
    }
  }
}

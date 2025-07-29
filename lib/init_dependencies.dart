import 'package:flutter_clean_architecture/core/app_secrets/app_secrets.dart';
import 'package:flutter_clean_architecture/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:flutter_clean_architecture/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecases/user_sign_in.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependecies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImp(serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignIn(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignup: serviceLocator(),
      userSignIn: serviceLocator(),
      currentUser: serviceLocator(),
    ),
  );
}

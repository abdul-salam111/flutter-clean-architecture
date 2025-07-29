import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Session? get currentSession;
  Future<UserModel> signupWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  });
  Future<UserModel> signinWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDatasourceImp implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;
  AuthRemoteDatasourceImp(this.supabaseClient);
  @override
  Session? get currentSession => supabaseClient.auth.currentSession;
  @override
  Future<UserModel> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerExceptions("User is null");
      }
      return UserModel.fromJson(
        response.user!.toJson(),
      ).copyWith(email: response.user!.email);
    } catch (error) {
      throw ServerExceptions(error.toString());
    }
  }

  @override
  Future<UserModel> signupWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerExceptions("User is null");
      }
      return UserModel.fromJson(
        response.user!.toJson(),
      ).copyWith(email: response.user!.email);
    } catch (error) {
      throw ServerExceptions(error.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentSession!.user.id);
        return UserModel.fromJson(
          userData.first,
        ).copyWith(email: currentSession!.user.email);
      }
      return null;
    } catch (error) {
      throw ServerExceptions(error.toString());
    }
  }
}

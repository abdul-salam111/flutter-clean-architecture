import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<String> signupWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  });
  Future<String> signinWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDatasourceImp implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;
  AuthRemoteDatasourceImp(this.supabaseClient);
  @override
  Future<String> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<String> signupWithEmailAndPassword({
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
      return response.user!.id;
    } catch (error) {
      throw ServerExceptions(error.toString());
    }
  }
}

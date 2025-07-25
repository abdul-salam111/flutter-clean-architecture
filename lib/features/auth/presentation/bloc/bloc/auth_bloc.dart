import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignup})
    : _userSignUp = userSignup,
      super(AuthInitial()) {
    on<AuthSignup>((event, emit) async {
      final response = await _userSignUp.call(
        UserSignUpParameters(
          email: event.email,
          name: event.name,
          password: event.password,
        ),
      );
      response.fold((left)=> emit(AuthFailure(left.message)), (onRight)=>AuthSuccess(onRight));
    });
  }
}

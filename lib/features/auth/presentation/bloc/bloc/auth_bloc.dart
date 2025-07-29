import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecases/user_sign_in.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;

  AuthBloc({
    required UserSignUp userSignup,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
  }) : _userSignUp = userSignup,
       _userSignIn = userSignIn,
       _currentUser = currentUser,
       super(AuthInitial()) {
    on<AuthSignup>(signUpUser);
    on<AuthSignIn>(signInUser);
    on<AuthIsUserLoggedIn>(isUserLoggedIn);
  }

  Future<void> signUpUser(AuthSignup event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final response = await _userSignUp.call(
      UserSignUpParameters(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );

    response.fold(
      (left) => emit(AuthFailure(left.message)),
      (right) => emit(AuthSuccess(right)),
    );
  }

  Future<void> signInUser(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final response = await _userSignIn.call(
      UserSignInParameters(email: event.email, password: event.password),
    );

    response.fold(
      (left) => emit(AuthFailure(left.message)),
      (right) => emit(AuthSuccess(right)),
    );
  }

  void isUserLoggedIn(AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    var response = await _currentUser(NoParams());
    response.fold((left) => emit(AuthFailure(left.message)), (right) {
      return emit(AuthSuccess(right));
    });
  }
}

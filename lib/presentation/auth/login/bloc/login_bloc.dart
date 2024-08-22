import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/repository/auth/auth_repository.dart';
import 'package:testerx2/router/router.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnUpdateLogin>((event, emit) => emit(LoginInitial()));

    on<OnLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        await GetIt.I<AuthRepository>().login(
          email: event.email.trim().toLowerCase(),
          password: event.password.trim(),
        );
        GetIt.I<AppRouter>().replaceAll([const HomeRoute()]);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          emit(LoginUserNotFound());
        } else if (e.code == "invalid-login-credentials") {
          emit(LoginWrongPassword());
        } else if (e.code == "network-request-failed") {
          emit(LoginConnectionWrong());
        } else {
          emit(LoginSomethingElse());
        }
        event.shakeKey.currentState?.shake();
      }
    });

    on<OnAnonymous>(
      (event, emit) async {
        emit(LoginLoading());
        try {
          await GetIt.I<AuthRepository>().login();
          GetIt.I<AppRouter>().replaceAll([const HomeRoute()]);
        } on FirebaseAuthException catch (e) {
          if (e.code == "network-request-failed") {
            emit(LoginConnectionWrong());
          } else {
            emit(LoginSomethingElse());
          }
        }
      },
    );
  }
}

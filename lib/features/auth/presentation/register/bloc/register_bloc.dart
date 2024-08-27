import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/repository/auth/auth_repository.dart';
import 'package:testerx2/core/router/router.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<OnUpdateRegister>((event, emit) => emit(RegisterInitial()));

    on<OnRegister>((event, emit) async {
      emit(RegisterLoading());
      if (event.password != event.password2) {
        emit(RegisterPasswordNotTheSame());
        event.shakeKey.currentState?.shake();
        return;
      }

      if (event.password.trim().isEmpty) {
        emit(RegisterMissingPassword());
        event.shakeKey.currentState?.shake();
        return;
      }

      try {
        var authRepo = GetIt.I<AuthRepository>();
        await authRepo.register(
          event.email.trim().toLowerCase(),
          event.password.trim(),
        );
        await authRepo.login(
          email: event.email.trim().toLowerCase(),
          password: event.password.trim(),
        );
        GetIt.I<AppRouter>().replaceAll([const HomeRoute()]);
      } on FirebaseAuthException catch (e) {
        if (e.code == "invalid-email") {
          emit(RegisterInvalidEmail());
        }
        if (e.code == 'weak-password') {
          emit(RegisterWeakPassword());
        } else if (e.code == "email-already-in-use") {
          emit(RegisterEmailAlreadyInUse());
        } else {
          emit(RegisterSomethingElse());
        }
        event.shakeKey.currentState?.shake();
      }
    });
  }
}

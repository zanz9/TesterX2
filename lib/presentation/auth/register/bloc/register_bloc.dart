import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/repository/auth/auth_repository.dart';
import 'package:testerx2/router/router.dart';

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

      try {
        await AuthRepository().register(
          event.email.trim().toLowerCase(),
          event.password.trim(),
        );
        await AuthRepository().login(
          email: event.email.trim().toLowerCase(),
          password: event.password.trim(),
        );
        GetIt.I<AppRouter>().replace(const MainRoute());
      } on FirebaseAuthException catch (e) {
        if (e.code == "invalid-email") {
          emit(RegisterInvalidEmail());
        } else if (e.code == "missing-password") {
          emit(RegisterMissingPassword());
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

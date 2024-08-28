import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gif_view/gif_view.dart';
import 'package:testerx2/repository/auth/auth_repository.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    on<OnUpdateForgetPassword>((event, emit) => emit(ForgetPasswordInitial()));

    on<OnForgetPassword>((event, emit) async {
      emit(ForgetPasswordLoading());
      try {
        await GetIt.I<AuthRepository>()
            .resetPassword(event.email.trim().toLowerCase());
        await Future.delayed(const Duration(seconds: 2));
        emit(ForgetPasswordInitial());
      } catch (e) {
        emit(ForgetPasswordFail());
      }
    });
  }
}

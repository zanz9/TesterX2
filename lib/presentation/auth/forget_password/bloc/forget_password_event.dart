part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordEvent {}

final class OnForgetPassword extends ForgetPasswordEvent {
  final String email;

  OnForgetPassword({required this.email});
}

final class OnUpdateForgetPassword extends ForgetPasswordEvent {}

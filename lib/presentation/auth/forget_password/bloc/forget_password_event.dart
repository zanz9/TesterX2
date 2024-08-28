part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordEvent {}

final class OnForgetPassword extends ForgetPasswordEvent {
  final String email;
  final GifController gifController;

  OnForgetPassword({required this.email, required this.gifController});
}

final class OnUpdateForgetPassword extends ForgetPasswordEvent {}

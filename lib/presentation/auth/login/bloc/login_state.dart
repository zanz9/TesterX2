part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginUserNotFound extends LoginState {}

final class LoginWrongPassword extends LoginState {}

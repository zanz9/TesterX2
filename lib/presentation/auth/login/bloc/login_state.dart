part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginUserNotFound extends LoginState {}

final class LoginWrongPassword extends LoginState {}

final class LoginAnonymous extends LoginState {}

final class LoginConnectionWrong extends LoginState {}

final class LoginSomethingElse extends LoginState {}

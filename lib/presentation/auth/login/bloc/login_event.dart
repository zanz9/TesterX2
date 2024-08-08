part of 'login_bloc.dart';

sealed class LoginEvent {}

final class OnLogin extends LoginEvent {
  final String email;
  final String password;
  final GlobalKey<ShakeWidgetState> shakeKey;

  OnLogin(
      {required this.email, required this.password, required this.shakeKey});
}

final class OnAnonymous extends LoginEvent {}

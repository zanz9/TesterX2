part of 'register_bloc.dart';

sealed class RegisterEvent {}

final class OnRegister extends RegisterEvent {
  final String email;
  final String password;
  final String password2;
  final GlobalKey<ShakeWidgetState> shakeKey;

  OnRegister({
    required this.email,
    required this.password,
    required this.password2,
    required this.shakeKey,
  });
}

final class OnUpdateRegister extends RegisterEvent {}

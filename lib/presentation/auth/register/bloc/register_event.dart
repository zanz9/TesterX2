part of 'register_bloc.dart';

sealed class RegisterEvent {}

final class OnRegister extends RegisterEvent {
  final String email;
  final String password;

  OnRegister({required this.email, required this.password});
}

part of 'register_bloc.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterPasswordWeak extends RegisterState {}

final class RegisterEmailAlreadyInUse extends RegisterState {}

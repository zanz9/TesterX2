part of 'register_bloc.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterInvalidEmail extends RegisterState {}

final class RegisterMissingPassword extends RegisterState {}

final class RegisterWeakPassword extends RegisterState {}

final class RegisterEmailAlreadyInUse extends RegisterState {}

final class RegisterSomethingElse extends RegisterState {}

final class RegisterPasswordNotTheSame extends RegisterState {}

part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class OnProfile extends ProfileEvent {}

class OnProfileChangeDisplayName extends ProfileEvent {
  final String displayName;

  OnProfileChangeDisplayName({required this.displayName});
}

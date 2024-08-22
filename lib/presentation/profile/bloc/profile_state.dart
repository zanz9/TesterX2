part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final AuthModel user;
  final List<HistoryModel> history;

  ProfileLoaded({required this.user, required this.history});
}

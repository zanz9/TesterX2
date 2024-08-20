part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeUserNotHaveGroup extends HomeState {}

final class HomeTestsLoaded extends HomeState {
  final AuthModel user;
  final List<TestModel> tests;

  HomeTestsLoaded({required this.tests, required this.user});
}

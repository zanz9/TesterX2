part of 'home_last_test_bloc.dart';

@immutable
sealed class HomeLastTestState {}

final class HomeLastTestInitial extends HomeLastTestState {}

final class HomeLastTestLoaded extends HomeLastTestState {
  final TestModel testModel;

  HomeLastTestLoaded({required this.testModel});
}

final class HomeLastTestNotFound extends HomeLastTestState {}

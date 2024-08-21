part of 'test_bloc.dart';

@immutable
sealed class TestState {}

final class TestInitial extends TestState {}

final class TestLoaded extends TestState {
  final int textIndex;
  final TestFileModel test;

  TestLoaded({required this.textIndex, required this.test});
}

part of 'test_finish_bloc.dart';

@immutable
sealed class TestFinishEvent {}

class OnTestFinish extends TestFinishEvent {
  final String testId;

  OnTestFinish({required this.testId});
}

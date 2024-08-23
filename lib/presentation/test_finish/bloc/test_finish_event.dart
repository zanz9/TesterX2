part of 'test_finish_bloc.dart';

@immutable
sealed class TestFinishEvent {}

class OnTestFinish extends TestFinishEvent {
  final String testId;

  OnTestFinish({required this.testId});
}

class OnTestFinishAgainPassTest extends TestFinishEvent {
  final TestModel testModel;

  OnTestFinishAgainPassTest({required this.testModel});
}

class OnTestFinishCheck extends TestFinishEvent {
  final TestModel testModel;
  final int testIndex;

  OnTestFinishCheck({required this.testModel, required this.testIndex});
}

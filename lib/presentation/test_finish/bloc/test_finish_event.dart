part of 'test_finish_bloc.dart';

@immutable
sealed class TestFinishEvent {}

class OnTestFinish extends TestFinishEvent {}

class OnTestFinishAgainPassTest extends TestFinishEvent {}

class OnTestFinishCheck extends TestFinishEvent {
  final TestModel testModel;
  final int testIndex;

  OnTestFinishCheck({required this.testModel, required this.testIndex});
}

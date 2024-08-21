part of 'test_bloc.dart';

@immutable
sealed class TestEvent {}

class OnTest extends TestEvent {
  final TestModel testModel;

  OnTest({required this.testModel});
}

class OnTestNext extends TestEvent {}

class OnTestPrev extends TestEvent {}

class OnTestIndexSet extends TestEvent {
  final int testIndex;

  OnTestIndexSet({required this.testIndex});
}

class OnTestAnswer extends TestEvent {
  final int index;

  OnTestAnswer({required this.index});
}

class OnTestSubmit extends TestEvent {}

class OnTestFinish extends TestEvent {}

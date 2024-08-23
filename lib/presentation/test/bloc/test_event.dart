part of 'test_bloc.dart';

@immutable
sealed class TestEvent {}

class OnTest extends TestEvent {}

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

class OnTestFinishAndExit extends TestEvent {}

class OnTestFinishClose extends TestEvent {
  final BuildContext context;

  OnTestFinishClose({required this.context});
}

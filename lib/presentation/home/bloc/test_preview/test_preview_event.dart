part of 'test_preview_bloc.dart';

@immutable
sealed class TestPreviewEvent {}

class OnTestPreview extends TestPreviewEvent {
  final TestModel test;

  OnTestPreview({required this.test});
}

class OnTestPreviewDelete extends TestPreviewEvent {
  final TestModel test;

  OnTestPreviewDelete({required this.test});
}

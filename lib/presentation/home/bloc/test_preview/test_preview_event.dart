part of 'test_preview_bloc.dart';

@immutable
sealed class TestPreviewEvent {}

class OnTestPreview extends TestPreviewEvent {
  final TestModel test;

  OnTestPreview({required this.test});
}

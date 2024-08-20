part of 'test_preview_bloc.dart';

@immutable
sealed class TestPreviewState {}

final class TestPreviewInitial extends TestPreviewState {}

final class TestPreviewLoading extends TestPreviewState {}

final class TestPreviewLoaded extends TestPreviewState {
  final TestModel test;

  TestPreviewLoaded({required this.test});
}

part of 'test_edit_bloc.dart';

@immutable
sealed class TestEditState {}

final class TestEditInitial extends TestEditState {}

final class TestEditLoading extends TestEditState {}

final class TestEditLoaded extends TestEditState {}

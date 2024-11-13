part of 'test_edit_bloc.dart';

@immutable
sealed class TestEditEvent {}

class OnTestEdit extends TestEditEvent {}

class OnTestEditSave extends TestEditEvent {}

class OnTestEditAnswerAdd extends TestEditEvent {}

class OnTestEditAnswerDelete extends TestEditEvent {
  final int index;

  OnTestEditAnswerDelete({required this.index});
}

class OnTestEditQuestionNext extends TestEditEvent {}

class OnTestEditQuestionPrev extends TestEditEvent {}

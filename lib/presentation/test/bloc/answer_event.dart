part of 'answer_bloc.dart';

sealed class AnswerEvent {}

final class OnPressed extends AnswerEvent {
  final bool isRight;
  final int indexAnswer;

  OnPressed({required this.indexAnswer, required this.isRight});
}

final class AddIndex extends AnswerEvent {
  final int index;

  AddIndex({required this.index});
}

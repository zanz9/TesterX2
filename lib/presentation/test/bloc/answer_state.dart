part of 'answer_bloc.dart';

sealed class AnswerState {}

final class AnswerInitial extends AnswerState {}

final class AnswerPressed extends AnswerState {
  final Map<int, Progress> progressMap;

  AnswerPressed({required this.progressMap});
}

final class AnswerRight extends AnswerState {}

final class AnswerWrong extends AnswerState {}

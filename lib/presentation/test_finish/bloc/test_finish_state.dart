part of 'test_finish_bloc.dart';

@immutable
sealed class TestFinishState {}

final class TestFinishInitial extends TestFinishState {}

final class TestFinishLoaded extends TestFinishState {
  final List<SortedByTestIdModel> otherHistoryList;
  final List<HistoryModel> myHistoryList;

  TestFinishLoaded({
    required this.otherHistoryList,
    required this.myHistoryList,
  });
}

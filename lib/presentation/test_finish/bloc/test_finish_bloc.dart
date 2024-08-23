import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/repository/repository.dart';

part 'test_finish_event.dart';
part 'test_finish_state.dart';

class TestFinishBloc extends Bloc<TestFinishEvent, TestFinishState> {
  TestFinishBloc() : super(TestFinishInitial()) {
    on<OnTestFinish>((event, emit) async {
      List<SortedByTestIdModel> otherHistoryList =
          await GetIt.I<SortedByTestIdRepository>().getLastSortedByTestId(
        testId: event.testId,
      );

      final uid = FirebaseAuth.instance.currentUser?.uid;
      List<HistoryModel> myHistoryList =
          await GetIt.I<HistoryRepository>().getAllHistoryByTestId(
        uid: uid!,
        testId: event.testId,
      );
      emit(TestFinishLoaded(
        otherHistoryList: otherHistoryList,
        myHistoryList: myHistoryList,
      ));
    });
  }
}

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/router/router.dart';

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

    on<OnTestFinishAgainPassTest>(
      (event, emit) async {
        var testModel = event.testModel;
        var tests =
            await GetIt.I<StorageRepository>().downloadTest(testModel.path);
        tests.shuffle();
        tests.length = testModel.tests.length;
        tests.map((e) => e.body.shuffle()).toList();
        testModel.tests = tests;
        await GetIt.I<SharedPreferences>()
            .setString('testModel', jsonEncode(testModel.toJsonAllFields()));
        await GetIt.I<SharedPreferences>().setInt('testIndex', 0);
        GetIt.I<AppRouter>().replaceAll([const TestPageRoute()]);
      },
    );

    on<OnTestFinishCheck>(
      (event, emit) async {
        var testModel = event.testModel;
        var testIndex = event.testIndex;
        await GetIt.I<SharedPreferences>()
            .setString('testModel', jsonEncode(testModel.toJsonAllFields()));
        await GetIt.I<SharedPreferences>().setInt('testIndex', testIndex);
        await GetIt.I<SharedPreferences>().setBool('testCheck', true);
        GetIt.I<AppRouter>().push(const TestPageRoute());
      },
    );
  }
}

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/core/router/router.dart';

part 'test_finish_event.dart';
part 'test_finish_state.dart';

class TestFinishBloc extends Bloc<TestFinishEvent, TestFinishState> {
  var prefs = GetIt.I<SharedPreferences>();
  int maxScoreTest = 0;
  int correct = 0;
  late TestModel testModel;
  TestFinishBloc() : super(TestFinishInitial()) {
    on<OnTestFinish>((event, emit) async {
      var testModelString = prefs.getString('testModel');
      if (testModelString == null) {
        return GetIt.I<AppRouter>().replaceAll([const HomeRoute()]);
      }
      testModel = TestModel.fromJsonAllFields(jsonDecode(testModelString));
      for (var e in testModel.tests) {
        correct += e.receive;
        maxScoreTest += e.maxScore;
      }

      List<SortedByTestIdModel> otherHistoryList =
          await GetIt.I<SortedByTestIdRepository>().getLastSortedByTestId(
        testId: testModel.id,
      );

      final uid = FirebaseAuth.instance.currentUser?.uid;
      List<HistoryModel> myHistoryList =
          await GetIt.I<HistoryRepository>().getAllHistoryByTestId(
        uid: uid!,
        testId: testModel.id,
      );
      emit(TestFinishLoaded(
        otherHistoryList: otherHistoryList,
        myHistoryList: myHistoryList,
      ));
    });

    on<OnTestFinishAgainPassTest>(
      (event, emit) async {
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

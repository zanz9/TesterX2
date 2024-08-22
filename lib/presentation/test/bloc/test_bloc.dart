import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/router/router.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  int testIndex = 0;
  late TestModel testModel;
  late List<TestFileModel> tests = testModel.tests;
  TestBloc() : super(TestInitial()) {
    on<OnTest>((event, emit) {
      testModel = event.testModel;
      // GetIt.I<SharedPreferences>().get
      emit(TestLoaded(textIndex: testIndex, test: tests[testIndex]));
    });

    on<OnTestNext>((event, emit) {
      if (testIndex < tests.length - 1) {
        emit(TestLoaded(textIndex: ++testIndex, test: tests[testIndex]));
      }
    });

    on<OnTestPrev>((event, emit) {
      if (testIndex > 0) {
        emit(TestLoaded(textIndex: --testIndex, test: tests[testIndex]));
      }
    });

    on<OnTestIndexSet>((event, emit) {
      testIndex = event.testIndex;
      emit(TestLoaded(textIndex: testIndex, test: tests[testIndex]));
    });

    on<OnTestAnswer>((event, emit) {
      var test = tests[testIndex];
      if (test.answered) return;
      var answerIndex = event.index;
      if (test.answers.contains(answerIndex)) {
        test.answers.remove(answerIndex);
      } else {
        test.answers.add(answerIndex);
      }

      emit(TestLoaded(textIndex: testIndex, test: tests[testIndex]));
    });

    on<OnTestSubmit>((event, emit) {
      var test = tests[testIndex];
      calculateTest(test);
      emit(TestLoaded(textIndex: testIndex, test: tests[testIndex]));
    });

    on<OnTestFinish>((event, emit) async {
      for (var test in tests) {
        calculateTest(test);
      }
      await GetIt.I<HistoryRepository>().addHistory(testModel);
      GetIt.I<AppRouter>().replaceAll([
        const HomeRoute(),
        TestFinishRoute(test: testModel),
      ]);
    });
  }

  int getCorrectCount() {
    return tests[testIndex].body.where((el) => el.score > 0).length;
  }

  calculateTest(TestFileModel test) {
    if (test.answered || test.answers.isEmpty) return;
    test.answered = true;
    test.receive = test.answers.fold<int>(
      0,
      (total, el) => total + (test.body[el].score),
    );
    test.receive = (getCorrectCount() - test.answers.length) + test.receive;
    if (test.receive < 0) test.receive = 0;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/repository/repository.dart';

part 'test_preview_event.dart';
part 'test_preview_state.dart';

class TestPreviewBloc extends Bloc<TestPreviewEvent, TestPreviewState> {
  TestPreviewBloc() : super(TestPreviewInitial()) {
    on<OnTestPreview>((event, emit) async {
      emit(TestPreviewLoading());
      TestModel test = event.test;
      test.tests = await StorageRepository().downloadTest(test.path);
      emit(TestPreviewLoaded(test: test));
    });
  }
}

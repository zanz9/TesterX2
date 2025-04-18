import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/core/di/init_di.dart';
import 'package:testerx2/presentation/home/bloc/home/home_bloc.dart';
import 'package:testerx2/repository/repository.dart';

part 'test_preview_event.dart';
part 'test_preview_state.dart';

class TestPreviewBloc extends Bloc<TestPreviewEvent, TestPreviewState> {
  bool isAdmin = false;
  TestPreviewBloc() : super(TestPreviewInitial()) {
    on<OnTestPreview>((event, emit) async {
      emit(TestPreviewLoading());
      TestModel test = event.test;
      isAdmin = await getIt<AuthRepository>().isAdmin();
      if (test.accessList != null && !isAdmin) {
        if (!test.accessList!.contains(getIt<AuthRepository>().getMyUid())) {
          return emit(TestPreviewError());
        }
      }
      test.tests = await GetIt.I<StorageRepository>().downloadTest(test.path);
      emit(TestPreviewLoaded(test: test));
    });
    on<OnTestPreviewDelete>(
      (event, emit) async {
        await GetIt.I<TestRepository>().deleteTest(event.test);
        GetIt.I<HomeBloc>().add(OnHome());
      },
    );
  }
}

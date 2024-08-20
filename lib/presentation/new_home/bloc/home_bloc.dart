import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/repository/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<OnHome>((event, emit) async {
      AuthModel? user = await GetIt.I<AuthRepository>().getUser();
      String? groupId = user!.groupId;
      if (groupId == null) return emit(HomeUserNotHaveGroup(user: user));
      List<TestModel> tests =
          await GetIt.I<TestRepository>().getAllTestByGroupId(groupId);
      if (tests.isEmpty) return emit(HomeUserGroupNotHaveTests(user: user));
      emit(HomeTestsLoaded(tests: tests, user: user));
    });
  }
}

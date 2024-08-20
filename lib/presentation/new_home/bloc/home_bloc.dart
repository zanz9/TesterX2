import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/repository/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<OnHome>((event, emit) async {
      AuthModel? user = await AuthRepository().getUser();
      String? groupId = user!.groupId;
      if (groupId == null) return emit(HomeUserNotHaveGroup());
      List<TestModel> tests =
          await TestRepository().getAllTestByGroupId(groupId);
      emit(HomeTestsLoaded(tests: tests, user: user));
    });
  }
}

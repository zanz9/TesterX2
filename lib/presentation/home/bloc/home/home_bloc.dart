import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:testerx2/presentation/profile/bloc/profile/profile_bloc.dart';
import 'package:testerx2/repository/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

@Singleton()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<OnHome>((event, emit) async {
      if (!GetIt.I<AuthRepository>().isAuth()) {
        var tests = await GetIt.I<TestRepository>().getLastTests();
        emit(HomeTestsLoaded(tests: tests, user: AuthModel()));
        return;
      }

      GetIt.I<ProfileBloc>().add(OnProfile());
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

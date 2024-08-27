import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/repository/repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<OnProfile>((event, emit) async {
      var authRepo = GetIt.I<AuthRepository>();
      AuthModel? user = await authRepo.getUser();
      List<HistoryModel> historyList = await GetIt.I<HistoryRepository>()
          .getAllHistory(authRepo.authInstance.currentUser!.uid);
      for (var e in historyList) {
        e.test = await GetIt.I<TestRepository>().getTestById(e.testId);
      }
      emit(ProfileLoaded(user: user!, history: historyList));
    });

    on<OnProfileChangeDisplayName>((event, emit) async {
      await GetIt.I<AuthRepository>().setUserDisplayName(event.displayName);
      add(OnProfile());
    });
  }
}

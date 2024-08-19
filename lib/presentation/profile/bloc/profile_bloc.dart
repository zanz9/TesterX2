import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/repository/auth/auth.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<OnProfile>((event, emit) async {
      var user = await AuthRepository().getUser();
      emit(ProfileLoaded(user: user!));
    });

    on<OnProfileChangeDisplayName>((event, emit) async {
      await AuthRepository().setUserDisplayName(event.displayName);
      var user = await AuthRepository().getUser();
      emit(ProfileLoaded(user: user!));
    });
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/repository/repository.dart';

part 'home_last_test_event.dart';
part 'home_last_test_state.dart';

class HomeLastTestBloc extends Bloc<HomeLastTestEvent, HomeLastTestState> {
  HomeLastTestBloc() : super(HomeLastTestInitial()) {
    on<HomeLastTestEvent>((event, emit) {
      var prefs = GetIt.I<SharedPreferences>();
      bool check = prefs.getBool('testCheck') ?? false;
      bool finish = prefs.getBool('testFinish') ?? false;
      if (check || finish) return emit(HomeLastTestNotFound());

      var testModelString = prefs.getString('testModel');
      if (testModelString == null) return emit(HomeLastTestNotFound());

      emit(HomeLastTestLoaded(
          testModel: TestModel.fromJsonAllFields(jsonDecode(testModelString))));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/repository/repository.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<OnAdmin>((event, emit) async {
      if (await AuthRepository().isAdmin()) {
        emit(AdminLoaded());
      }
    });
  }
}

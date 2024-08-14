import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/repository/repository.dart';

part 'add_group_event.dart';
part 'add_group_state.dart';

class AddGroupBloc extends Bloc<AddGroupEvent, AddGroupState> {
  AddGroupBloc() : super(AddGroupInitial()) {
    on<OnUpdateAddGroup>((event, emit) => emit(AddGroupInitial()));

    on<OnAddGroup>((event, emit) async {
      emit(AddGroupLoading());

      if (event.name.trim().isEmpty) {
        emit(AddGroupFail());
        return;
      }

      try {
        await GroupRepository().addGroup(name: event.name.trim());
        emit(AddGroupSuccess());
      } catch (e) {
        emit(AddGroupFail());
      }
    });
  }
}

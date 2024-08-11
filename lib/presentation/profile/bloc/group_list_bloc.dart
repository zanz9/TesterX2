import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/repository/repository.dart';

part 'group_list_event.dart';
part 'group_list_state.dart';

class GroupListBloc extends Bloc<GroupListEvent, GroupListState> {
  GroupListBloc() : super(GroupListInitial()) {
    on<OnGroupList>((event, emit) async {
      var groupRepo = GroupRepository();

      var groups = await groupRepo.getAllGroup();
      emit(GroupListLoaded(list: groups));
    });
  }
}

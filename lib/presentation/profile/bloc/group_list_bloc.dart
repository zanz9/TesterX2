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
      var myGroup = await groupRepo.getMyGroup();
      emit(GroupListLoaded(list: groups, myGroup: myGroup));
    });

    on<OnUpdateUserGroupList>((event, emit) async {
      var authRepo = AuthRepository();
      var user = await authRepo.getUser();
      if (user == null) return;
      user.groupId = event.myGroup.id;
      authRepo.updateUser(data: user);
      emit(GroupListLoaded(list: event.list, myGroup: event.myGroup.name));
    });
  }
}

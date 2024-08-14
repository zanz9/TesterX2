part of 'group_list_bloc.dart';

@immutable
sealed class GroupListEvent {}

class OnGroupList extends GroupListEvent {}

class OnUpdateUserGroupList extends GroupListEvent {
  final GroupModel myGroup;
  final List<GroupModel> list;

  OnUpdateUserGroupList({required this.myGroup, required this.list});
}

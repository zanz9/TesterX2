part of 'group_list_bloc.dart';

@immutable
sealed class GroupListState {}

final class GroupListInitial extends GroupListState {}

final class GroupListLoaded extends GroupListState {
  final List<GroupModel> list;

  GroupListLoaded({required this.list});
}

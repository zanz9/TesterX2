part of 'add_group_bloc.dart';

@immutable
sealed class AddGroupEvent {}

class OnAddGroup extends AddGroupEvent {
  final String name;

  OnAddGroup({required this.name});
}

class OnUpdateAddGroup extends AddGroupEvent {}

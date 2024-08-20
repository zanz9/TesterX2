part of 'add_group_bloc.dart';

@immutable
sealed class AddGroupState {}

final class AddGroupInitial extends AddGroupState {}

final class AddGroupLoading extends AddGroupState {}

final class AddGroupSuccess extends AddGroupState {}

final class AddGroupFail extends AddGroupState {}

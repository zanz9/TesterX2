import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/profile/bloc/group_list_bloc.dart';

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = GroupListBloc();
    bloc.add(OnGroupList());

    return BlocBuilder<GroupListBloc, GroupListState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is GroupListLoaded) {
          return Scaffold(
            body: SafeArea(
              child: ListView.separated(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  var item = state.list[index];
                  return ListTile(
                    title: Text(item['name']),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

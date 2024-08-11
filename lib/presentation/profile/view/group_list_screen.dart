import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/profile/bloc/group_list_bloc.dart';
import 'package:testerx2/ui/ui.dart';

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
              child: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  var item = state.list[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: PrimaryListWidget(
                      text: item.name,
                    ),
                  );
                },
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

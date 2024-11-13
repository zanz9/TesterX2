import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testerx2/core/di/init_di.dart';
import 'package:testerx2/presentation/profile/bloc/group_list/group_list_bloc.dart';
import 'package:testerx2/presentation/profile/view/group_list_screen.dart';

class UserGroupWidget extends StatefulWidget {
  const UserGroupWidget({
    super.key,
  });

  @override
  State<UserGroupWidget> createState() => _UserGroupWidgetState();
}

class _UserGroupWidgetState extends State<UserGroupWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupListBloc, GroupListState>(
      bloc: getIt<GroupListBloc>()..add(OnGroupList()),
      builder: (context, state) {
        if (state is GroupListLoaded) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => const SizedBox(
                    height: 600,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: GroupListScreen(),
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Группа: ${state.myGroup}',
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 12),
                        Text(
                          'Сменить группу',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 16,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

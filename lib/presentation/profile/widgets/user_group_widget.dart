import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/presentation/profile/view/group_list_screen.dart';
import 'package:testerx2/repository/repository.dart';

class UserGroupWidget extends StatefulWidget {
  const UserGroupWidget({
    super.key,
  });

  @override
  State<UserGroupWidget> createState() => _UserGroupWidgetState();
}

class _UserGroupWidgetState extends State<UserGroupWidget> {
  String userGroup = '';

  getMyGroup() {
    GroupRepository().getMyGroup().then((value) {
      setState(() {
        userGroup = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getMyGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        transitionDuration: const Duration(milliseconds: 350),
        openBuilder: (context, action) => const GroupListScreen(),
        closedElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        closedColor: Colors.black,
        closedBuilder: (context, action) => Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Text(
                'Группа: $userGroup',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const Row(
                children: [
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
}

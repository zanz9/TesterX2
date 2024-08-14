import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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

  getMyGroup() async {
    String? myGroup = await GroupRepository().getMyGroup();
    setState(() {
      userGroup = myGroup ?? 'Не выбрана';
    });
  }

  @override
  void initState() {
    super.initState();
    getMyGroup();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var a = await showCupertinoModalBottomSheet(
          context: context,
          builder: (context) => const SizedBox(
            height: 600,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: GroupListScreen(),
            ),
          ),
        );
        if (a == null) {
          getMyGroup();
        }
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
                'Группа: $userGroup',
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
    );
  }
}

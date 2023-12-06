import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/ui/ui.dart';
import 'package:testerx2/utils/firestore/groups.dart';
import 'package:testerx2/utils/utils.dart';

class BuildChangeUserGroup extends StatefulWidget {
  const BuildChangeUserGroup({
    super.key,
  });

  @override
  State<BuildChangeUserGroup> createState() => _BuildChangeUserGroupState();
}

class _BuildChangeUserGroupState extends State<BuildChangeUserGroup> {
  String? userGroup;
  String? userGroupID;
  List groups = [];

  @override
  void initState() {
    super.initState();
    GroupService().getUserGroup().then((value) {
      setState(() {
        userGroupID = value?[0];
        userGroup = value?[1];
      });
    });
    GroupService().getGroups().then((value) {
      setState(() {
        for (var element in value.entries) {
          groups.add([element.key, element.value.toString()]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: ListContainer(
        bodyText: 'Сменить группу',
        secondaryText: userGroup,
        rightSide: Icon(
          Icons.arrow_forward_ios_rounded,
          color: theme.hintColor,
        ),
        onTap: () {
          if (userGroupID == null) {
            userGroup = groups[0][1];
            userGroupID = groups[0][0];
          }
          showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoActionSheet(
              title: const Text('Сменить группу'),
              actions: [
                CupertinoPicker(
                  itemExtent: 50.0,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      userGroup = groups[index][1];
                      userGroupID = groups[index][0];
                    });
                  },
                  children: groups.map((dynamic group) {
                    return Center(
                      child: Text(
                        group[1],
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    );
                  }).toList(),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    GroupService().setUserGroup(userGroupID!);
                    Navigator.pop(context);
                  },
                  child: const Text('Сменить'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

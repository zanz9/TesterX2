import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/ui/ui.dart';
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
  List<String>? groups;
  @override
  void initState() {
    groups = [];
    AuthService().getGroups().then((value) {
      setState(() {
        for (var v in value.values) {
          groups!.add(v.toString());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    setUserGroup() {
      AuthService().setUserGroup('FCnDKpk25VR0J1GgfqGY');
    }

    return SliverToBoxAdapter(
      child: ListContainer(
        bodyText: 'Сменить группу',
        secondaryText: userGroup,
        rightSide: Icon(
          Icons.arrow_forward_ios_rounded,
          color: theme.hintColor,
        ),
        onTap: () {
          showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoActionSheet(
              title: const Text('Сменить группу'),
              message: DropdownMenu(
                initialSelection: groups!.first,
                dropdownMenuEntries:
                    groups!.map<DropdownMenuEntry<String>>((value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {},
                  child: const Text('Сменить'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

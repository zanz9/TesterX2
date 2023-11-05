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
  @override
  void initState() {
    AuthService().getUserGroup().then((value) {
      setState(() {
        userGroup = value;
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
          setUserGroup();
        },
      ),
    );
  }
}

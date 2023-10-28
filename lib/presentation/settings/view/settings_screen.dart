import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:testerx2/presentation/settings/settings.dart';
import 'package:testerx2/ui/ui.dart';
import 'package:testerx2/utils/firestore/auth_service.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isAdmin = false;
  @override
  void initState() {
    isAdminCheck();
    super.initState();
  }

  isAdminCheck() async {
    var isAdminTemp = await AuthService().isAdmin();
    setState(() {
      isAdmin = isAdminTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('Настройки')),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const BuildChangeTheme(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const BuildUseFilesFromFolder(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const BuildChangeLocalFolder(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          if (isAdmin) const BuildSendTestToDB(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const BuildChangeUserGroup(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const BuildExitFromAccount(),
        ],
      ),
    );
  }
}

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

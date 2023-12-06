import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:testerx2/presentation/settings/settings.dart';
import 'package:testerx2/utils/firestore/auth.dart';

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
    super.initState();
    isAdminCheck();
  }

  isAdminCheck() async {
    bool isAdminTemp = await AuthService().isAdmin();
    setState(() {
      isAdmin = isAdminTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await isAdminCheck();
      },
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Настройки'),
            automaticallyImplyLeading: false,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const BuildChangeTheme(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const BuildUseFilesFromFolder(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          if (isAdmin) const BuildSendTestToDB(),
          if (isAdmin) const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const BuildChangeUserGroup(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const BuildExitFromAccount(),
        ],
      ),
    );
  }
}

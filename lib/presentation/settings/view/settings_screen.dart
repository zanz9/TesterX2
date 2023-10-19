import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:testerx2/presentation/settings/settings.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text('Настройки')),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          BuildChangeTheme(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          BuildUseFilesFromFolder(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          BuildChangeLocalFolder(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          BuildSendTestToDB(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          BuildExitFromAccount(),
        ],
      ),
    );
  }
}

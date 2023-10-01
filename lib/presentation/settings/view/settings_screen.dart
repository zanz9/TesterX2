import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/presentation/settings/settings.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/widgets/index.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  Future<void> pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      return;
    }
    //! shared_preferense save folder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('Настройки')),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const ToggleContainer(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: ListContainer(
              bodyText: 'Редактор',
              rightSide: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                context.router.push(const TestEditorRoute());
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: ListContainer(
              bodyText: 'Изменить папку',
              secondaryText: 'Папка в которой хранятся файлы для теста',
              rightSide: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                pickFolder();
              },
            ),
          ),
        ],
      ),
    );
  }
}

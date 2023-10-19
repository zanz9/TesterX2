import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/ui/ui.dart';

class BuildChangeLocalFolder extends StatelessWidget {
  const BuildChangeLocalFolder({super.key});
  Future<void> pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      return;
    }
    //! shared_preferense save folder
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: ListContainer(
        bodyText: 'Изменить папку',
        secondaryText: 'Папка в которой хранятся файлы для теста',
        rightSide: Icon(
          Icons.arrow_forward_ios_rounded,
          color: theme.hintColor,
        ),
        onTap: () {
          pickFolder();
        },
      ),
    );
  }
}

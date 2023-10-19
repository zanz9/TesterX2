import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/presentation/settings/settings.dart';
import 'package:testerx2/utils/shared_preferences/index.dart';

class BuildUseFilesFromFolder extends StatelessWidget {
  const BuildUseFilesFromFolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LocalTxFiles localTxFiles = GetIt.I<LocalTxFiles>();
    bool value = localTxFiles.isUse;

    return ToggleContainer(
      bodyText: 'Использовать файлы из папки',
      initialValue: value,
      onTap: () {
        localTxFiles.setLocalTxFiles(!value);
        value = !value;
      },
    );
  }
}

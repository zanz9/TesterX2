import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testerx2/presentation/settings/settings.dart';
import 'package:testerx2/ui/theme/provider.dart';

class BuildChangeTheme extends StatelessWidget {
  const BuildChangeTheme({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleContainer(
      bodyText: 'Темная тема',
      initialValue:
          Provider.of<ThemeSettings>(context).currentTheme == ThemeMode.dark,
      onTap: () =>
          Provider.of<ThemeSettings>(context, listen: false).toggleTheme(),
    );
  }
}

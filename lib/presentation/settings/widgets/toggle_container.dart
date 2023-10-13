import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/myapp.dart';
import 'package:testerx2/ui/ui.dart';

class ToggleContainer extends StatefulWidget {
  const ToggleContainer({
    super.key,
  });

  @override
  State<ToggleContainer> createState() => _SettingsListContainerState();
}

class _SettingsListContainerState extends State<ToggleContainer> {
  bool value = false;

  changeTheme() {
    if (value) {
      MyApp.of(context).changeTheme(ThemeMode.dark);
    } else {
      MyApp.of(context).changeTheme(ThemeMode.light);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      value = MyApp.of(context).theme == ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListContainer(
        bodyText: 'Тёмная тема',
        rightSide: CupertinoSwitch(
          value: value,
          onChanged: (v) {
            setState(() {
              value = v;
              changeTheme();
            });
          },
        ),
        onTap: () {
          setState(() {
            value = !value;
            changeTheme();
          });
        },
      ),
    );
  }
}

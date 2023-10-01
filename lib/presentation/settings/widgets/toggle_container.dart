import 'package:flutter/cupertino.dart';
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
            });
          },
        ),
        onTap: () {
          setState(() {
            value = !value;
          });
        },
      ),
    );
  }
}

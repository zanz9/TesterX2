import 'package:flutter/cupertino.dart';
import 'package:testerx2/ui/ui.dart';

class ToggleContainer extends StatefulWidget {
  const ToggleContainer({
    super.key,
    required this.bodyText,
    required this.onTap,
    required this.initialValue,
  });
  final String bodyText;
  final Function() onTap;
  final bool initialValue;
  @override
  State<ToggleContainer> createState() => _SettingsListContainerState();
}

class _SettingsListContainerState extends State<ToggleContainer> {
  bool value = false;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListContainer(
        bodyText: widget.bodyText,
        rightSide: CupertinoSwitch(
          value: value,
          onChanged: (v) {
            setState(() {
              value = v;
              widget.onTap();
            });
          },
        ),
        onTap: () {
          setState(() {
            value = !value;
            widget.onTap();
          });
        },
      ),
    );
  }
}

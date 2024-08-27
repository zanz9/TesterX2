import 'package:flutter/widgets.dart';
import 'package:testerx2/features/profile/profile.dart';

class DevWidgets extends StatelessWidget {
  const DevWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Для разработчикам',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        ClearPrefs(),
      ],
    );
  }
}

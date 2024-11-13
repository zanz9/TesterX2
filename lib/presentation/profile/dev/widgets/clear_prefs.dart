import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/presentation/widgets/primary_list_widget.dart';

class ClearPrefs extends StatelessWidget {
  const ClearPrefs({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const PrimaryListWidget(
        text: 'Очистить настройки',
      ),
      onTap: () async {
        await GetIt.I<SharedPreferences>().clear();
      },
    );
  }
}

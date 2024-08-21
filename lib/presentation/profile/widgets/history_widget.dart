import 'package:flutter/material.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/ui/ui.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({
    super.key,
    required this.history,
  });
  final List<HistoryModel> history;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'История',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          itemBuilder: (context, index) {
            return PrimaryListWidget(
              text: history[index].test.name,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      ],
    );
  }
}

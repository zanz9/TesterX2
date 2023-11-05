import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TestEditorScreen extends StatelessWidget {
  const TestEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    List<TextEditingController> answersController = [
      for (int counter = 0; counter < 5; counter++) TextEditingController()
    ];
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактор'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.subdirectory_arrow_left),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            Text(
              'Вопрос',
              style: theme.textTheme.bodyLarge,
            ),
            CupertinoTextField(
              controller: titleController,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            for (int counter = 0; counter < 5; counter++)
              AnswerFlied(
                count: counter + 1,
                controller: answersController[counter],
              ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CupertinoButton.filled(child: const Text('<<'), onPressed: () {}),
            CupertinoButton.filled(child: const Text('>>'), onPressed: () {})
          ],
        ),
      ),
    );
  }
}

class AnswerFlied extends StatefulWidget {
  const AnswerFlied({
    super.key,
    required this.count,
    required this.controller,
  });
  final int count;
  final TextEditingController controller;
  @override
  State<AnswerFlied> createState() => _AnswerFliedState();
}

class _AnswerFliedState extends State<AnswerFlied> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ответ ${widget.count}',
          style: theme.textTheme.bodyLarge,
        ),
        Row(
          children: [
            CupertinoCheckbox(
              value: isCheck,
              onChanged: (value) {
                setState(() {
                  isCheck = value!;
                });
              },
            ),
            Flexible(
              child: CupertinoTextField(
                style: theme.textTheme.bodyMedium,
                controller: widget.controller,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

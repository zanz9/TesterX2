import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/ui.dart';

class BuildTestEditor extends StatelessWidget {
  const BuildTestEditor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: ListContainer(
        bodyText: 'Редактор',
        rightSide: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Название теста'),
              content: CupertinoTextField.borderless(
                style: theme.textTheme.bodyLarge,
                autocorrect: false,
                autofocus: true,
              ),
              actions: [
                CupertinoButton(
                  child: const Text('Отмена'),
                  onPressed: () {
                    context.router.pop();
                  },
                ),
                CupertinoButton(
                  child: const Text('Создать'),
                  onPressed: () {
                    context.router.push(const TestEditorRoute());
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

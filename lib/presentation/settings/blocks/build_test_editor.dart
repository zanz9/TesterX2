import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/ui.dart';

class BuildTestEditor extends StatelessWidget {
  const BuildTestEditor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListContainer(
        bodyText: 'Редактор',
        rightSide: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {
          context.router.push(const TestEditorRoute());
        },
      ),
    );
  }
}

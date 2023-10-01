import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TestEditorScreen extends StatelessWidget {
  const TestEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактор'),
        actions: [
          IconButton(
            onPressed: () {
              controller.text += '\n';
            },
            icon: const Icon(Icons.subdirectory_arrow_left),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints.expand(width: 10000),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                autofocus: true,
                showCursor: true,
                autocorrect: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/presentation/presentation.dart';

@RoutePage()
class TestEditScreen extends StatelessWidget {
  const TestEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();

    TextEditingController questionController = TextEditingController();
    List<TextEditingController> controllers = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding:
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
          children: [
            const Text(
              'Название теста:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            PrimaryInput(
              controller: titleController,
              hintText: 'Название теста',
            ),
            TestEditLabelWithInput(
              controller: questionController,
              labelText: 'Вопрос - 1',
              hindText: 'Вопрос',
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: controllers.length,
              itemBuilder: (context, index) {
                return TestEditLabelWithInput(
                  controller: controllers[index],
                  labelText: 'Ответ - ${index + 1}',
                  hindText: 'Ответ',
                  isAnswer: true,
                );
              },
            ),
            const SizedBox(height: 32),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      '+ Добавить ответ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 72,
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_back))),
            Expanded(
                child: PrimaryButton(
                    padding: EdgeInsets.zero,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    onTap: () {},
                    isLoading: false,
                    child: const Text('Сохранить тест',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_forward)))
          ],
        ),
      ),
    );
  }
}

class TestEditLabelWithInput extends StatefulWidget {
  const TestEditLabelWithInput({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hindText,
    this.isAnswer = false,
  });

  final TextEditingController controller;
  final String labelText;
  final String hindText;
  final bool isAnswer;

  @override
  State<TestEditLabelWithInput> createState() => _TestEditLabelWithInputState();
}

class _TestEditLabelWithInputState extends State<TestEditLabelWithInput> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          widget.labelText,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        PrimaryInput(
          controller: widget.controller,
          hintText: widget.hindText,
          prefixIcon: widget.isAnswer
              ? MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => setState(() => isChecked = !isChecked),
                    child: Icon(isChecked
                        ? Icons.check_box
                        : Icons.check_box_outline_blank),
                  ),
                )
              : null,
          suffixIcon: widget.isAnswer
              ? MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: const Icon(Icons.cancel),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}

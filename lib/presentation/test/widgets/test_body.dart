import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:testerx2/models/index.dart';
import 'package:testerx2/presentation/test/widgets/index.dart';

class TestBody extends StatelessWidget {
  const TestBody({
    super.key,
    required this.question,
    required this.pageController,
    required this.indexPage,
  });

  final int indexPage;
  final Question question;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: HtmlWidget(
                question.title![0],
                textStyle: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Divider(height: 8),
          const SizedBox(height: 6),
          AnswerButton(
            question: question,
            indexPage: indexPage,
            pageController: pageController,
          )
        ],
      ),
    );
  }
}

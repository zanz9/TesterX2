import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:testerx2/models/index.dart';
import 'package:testerx2/presentation/test/widgets/index.dart';

class TestBody extends StatefulWidget {
  const TestBody({
    super.key,
    required this.question,
    required this.pageController,
  });

  final Question question;
  final PageController pageController;

  @override
  State<TestBody> createState() => _TestBodyState();
}

class _TestBodyState extends State<TestBody> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: HtmlWidget(
                widget.question.title![0],
                textStyle: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Divider(height: 8),
          const SizedBox(height: 6),
          ListView.separated(
            shrinkWrap: true,
            itemCount: widget.question.answers!.length,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
              height: 12,
            ),
            itemBuilder: (context, index) {
              return AnswerButton(
                index: index,
                answer: widget.question.answers![index],
                isRight: (widget.question.answers![index] ==
                    widget.question.rights!.first),
                pageController: widget.pageController,
              );
            },
          ),
        ],
      ),
    );
  }
}

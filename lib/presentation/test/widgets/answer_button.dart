import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:testerx2/models/index.dart';
import 'package:testerx2/presentation/test/cubit/answer_cubit.dart';
import 'package:testerx2/presentation/test/models/progress.dart';

class AnswerButton extends StatefulWidget {
  const AnswerButton({
    super.key,
    required this.question,
    required this.indexPage,
    required this.pageController,
  });

  final int indexPage;
  final Question question;
  final PageController pageController;

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.question.answers!.length,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(
        height: 12,
      ),
      itemBuilder: (context, index) {
        bool isRight =
            widget.question.answers![index] == widget.question.rights!.first;
        Color bgColor = Colors.white;

        if (isPressed) {
          if (context.read<AnswerCubit>().state[widget.indexPage]!.selected ==
              index) {
            if (isRight) {
              bgColor = Colors.greenAccent;
            } else {
              bgColor = Colors.redAccent;
            }
          } else {
            if (isRight) {
              bgColor = Colors.greenAccent;
            }
          }
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: bgColor),
          child: InkWell(
            splashColor: Colors.black.withOpacity(.04),
            highlightColor: Colors.black.withOpacity(.04),
            onTap: () {
              if (isPressed) {
                widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
                return;
              }
              Progress progress = Progress(
                page: widget.indexPage,
                selected: index,
              );
              context.read<AnswerCubit>().add(widget.indexPage, progress);
              setState(() {
                isPressed = true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: HtmlWidget(widget.question.answers![index]),
            ),
          ),
        );
      },
    );
  }
}

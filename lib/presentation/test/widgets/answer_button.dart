import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:testerx2/presentation/test/bloc/answer_bloc.dart';
import 'package:testerx2/presentation/test/cubit/test_current_page_cubit.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answer,
    required this.index,
    required this.isRight,
    required this.pageController,
  });

  final String answer;
  final int index;
  final bool isRight;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnswerBloc, AnswerState>(
      builder: (context, state) {
        Color bgColor = Colors.white;
        bool isPressed = false;
        if (state is AnswerPressed) {
          final progressMap = state.progressMap;
          final progress =
              progressMap[context.read<TestCurrentPageCubit>().state];
          if (progress != null) {
            if (progress.selected == index && isRight) {
              bgColor = Colors.greenAccent;
            } else if (progress.selected == index && !isRight) {
              bgColor = Colors.redAccent;
            } else if (progress.selected != index && isRight) {
              bgColor = Colors.greenAccent;
            }
            isPressed = true;
          }
        }
        void onTap() {
          if (isPressed) {
            context.read<AnswerBloc>().emit(AnswerInitial());
            pageController.nextPage(
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            );
          } else {
            context
                .read<AnswerBloc>()
                .add(OnPressed(isRight: isRight, indexAnswer: index));
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
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: HtmlWidget(answer),
            ),
          ),
        );
      },
    );
  }
}

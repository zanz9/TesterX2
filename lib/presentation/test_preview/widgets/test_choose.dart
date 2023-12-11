import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/models/index.dart';
import 'package:testerx2/presentation/test_preview/cubit/test_length_cubit.dart';
import 'package:testerx2/presentation/test_preview/test_preview.dart';
import 'package:testerx2/router/router.dart';

class TestChoose extends StatelessWidget {
  const TestChoose({
    super.key,
    required this.data,
    required this.testName,
    this.testId,
  });

  final TX data;
  final String testName;
  final String? testId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          TestChooseButton(
            icon: const Icon(
              Icons.cancel,
              size: 80,
              color: Colors.redAccent,
            ),
            onTap: () {
              context.router.back();
            },
          ),
          const SizedBox(width: 16),
          BlocBuilder<TestLengthCubit, double>(
            builder: (context, state) {
              return TestChooseButton(
                icon: const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.lightGreen,
                ),
                onTap: () {
                  // final bool multiple = data.multiple!;
                  List<Question> questions = data.questions!;
                  questions.shuffle();
                  questions.length = state.toInt();
                  questions.map((e) => e.answers?.shuffle()).toList();
                  context.router.replace(
                    TestPageRoute(
                      testName: testName,
                      questions: data.questions!,
                      testId: testId,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

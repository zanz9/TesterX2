import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/models/question.dart';
import 'package:testerx2/models/tx.dart';
import 'package:testerx2/presentation/test_preview/cubit/test_length_cubit.dart';
import 'package:testerx2/presentation/test_preview/test_preview.dart';
import 'package:testerx2/router/router.dart';

@RoutePage()
class TestPreviewScreen extends StatelessWidget {
  const TestPreviewScreen({
    super.key,
    required this.testName,
    required this.file,
    required this.qBackup,
    required this.testId,
  });
  final String testName;
  final File? file;
  final String? qBackup;
  final String testId;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var temp2;
    if (file != null) {
      final temp = file!.readAsStringSync();
      temp2 = jsonDecode(temp);
    } else {
      temp2 = jsonDecode(qBackup!);
    }

    TX data = TX.fromJson(temp2);
    int length = data.questions!.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(testName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   height: 200,
          //   color: theme.hintColor.withOpacity(0.15),
          //   child: const Center(child: Text('РЕКЛАМА')),
          // ),
          // const SizedBox(height: 12),
          const SizedBox(height: 12),
          BlocProvider(
            create: (context) => TestLengthCubit(),
            child: Column(
              children: [
                TestLengthSlider(
                  sliderLength: length.toDouble(),
                ),
                const SizedBox(height: 16),
                TestChoose(
                  data: data,
                  testName: testName,
                  testId: testId,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TestChoose extends StatelessWidget {
  const TestChoose({
    super.key,
    required this.data,
    required this.testName,
    required this.testId,
  });

  final TX data;
  final String testName;
  final String testId;

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
                  String qBackup =
                      jsonEncode(data.toJson()); //! shared_preference

                  // final bool multiple = data.multiple!;
                  List<Question> questions = data.questions!;
                  questions.shuffle();
                  questions.length = state.toInt();
                  questions.map((e) => e.answers?.shuffle()).toList();
                  context.router.replace(
                    TestPageRoute(
                      testName: testName,
                      questions: data.questions!,
                      qBackup: qBackup,
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

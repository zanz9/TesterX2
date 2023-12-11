import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/models/tx.dart';
import 'package:testerx2/presentation/test_preview/cubit/test_length_cubit.dart';
import 'package:testerx2/presentation/test_preview/test_preview.dart';
import 'package:testerx2/presentation/test_preview/widgets/test_choose.dart';
import 'package:testerx2/utils/firestore/test.dart';

@RoutePage()
class TestPreviewScreen extends StatefulWidget {
  const TestPreviewScreen({
    super.key,
    required this.testName,
    this.file,
    this.testId,
  });
  final String testName;
  final File? file;
  final String? testId;

  @override
  State<TestPreviewScreen> createState() => _TestPreviewScreenState();
}

class _TestPreviewScreenState extends State<TestPreviewScreen> {
  Map? test;
  TX? txData;
  bool loaded = false;

  @override
  void initState() {
    if (widget.file != null) {
      final temp = widget.file!.readAsStringSync();
      setState(() {
        txData = TX.fromJson(jsonDecode(temp));
      });
    } else {
      TestService().getTestById(widget.testId!).then((value) {
        setState(() {
          test = value;
          txData = value!['txData'];
          loaded = true;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      return const Center(child: CircularProgressIndicator());
    } else {
      int length = txData!.questions!.length;
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.testName),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    data: txData!,
                    testName: widget.testName,
                    testId: widget.testId,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

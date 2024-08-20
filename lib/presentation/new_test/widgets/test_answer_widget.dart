import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/repository/repository.dart';

class TestAnswerWidget extends StatefulWidget {
  const TestAnswerWidget({
    super.key,
    required this.test,
    required this.index,
    required this.correctCount,
  });

  final TestFileModel test;
  final int index;
  final int correctCount;

  @override
  State<TestAnswerWidget> createState() => _TestAnswerWidgetState();
}

class _TestAnswerWidgetState extends State<TestAnswerWidget> {
  @override
  Widget build(BuildContext context) {
    var answered = widget.test.answered;
    var isPressed = widget.test.answers.contains(widget.index);
    var isRight = widget.test.body[widget.index].score > 0;
    return GestureDetector(
      onTap: () {
        if (answered) return;
        setState(() {
          if (widget.test.answers.contains(widget.index)) {
            widget.test.answers.remove(widget.index);
            return;
          }
          widget.test.answers.add(widget.index);
        });
      },
      // onDoubleTap: () {
      //   if (answered) return;
      //   setState(() {
      //     widget.test.answers.clear();
      //     widget.test.answers.add(widget.index);
      //   });
      // },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
        ),
        child: Wrap(
          children: [
            Icon(
              widget.test.answers.contains(widget.index)
                  ? Icons.circle
                  : Icons.circle_outlined,
              color: answered
                  ? isRight
                      ? Colors.green
                      : isPressed
                          ? Colors.red
                          : Colors.black
                  : Colors.black,
            ),
            const SizedBox(width: 6),
            ...widget.test.body[widget.index].text
                .split('<testerx_img>')
                .map((el) {
              if (el != el.split('TESTERX').last) {
                Uint8List u8 = base64Decode(el.split('TESTERX').last);
                return Image.memory(u8);
              } else {
                return Text(
                  el,
                  style: TextStyle(
                    fontSize: 18,
                    color: answered
                        ? isRight
                            ? Colors.green
                            : isPressed
                                ? Colors.red
                                : Colors.black
                        : Colors.black,
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

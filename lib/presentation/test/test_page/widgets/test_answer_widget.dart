import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/presentation/test/test.dart';
import 'package:testerx2/repository/repository.dart';

class TestAnswerWidget extends StatelessWidget {
  const TestAnswerWidget({
    super.key,
    required this.test,
    required this.index,
    required this.bloc,
  });

  final TestFileModel test;
  final int index;
  final TestBloc bloc;

  @override
  Widget build(BuildContext context) {
    var answered = test.answered;
    var isPressed = test.answers.contains(index);
    var isRight = test.body[index].score > 0;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onDoubleTap: () {
          bloc.add(OnTestAnswer(index: index));
          bloc.add(OnTestSubmit());
        },
        onTap: () => bloc.add(OnTestAnswer(index: index)),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
          ),
          child: Wrap(
            children: [
              Icon(
                test.answers.contains(index)
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
              ...test.body[index].text.split('<testerx_img>').map((el) {
                if (el != el.split('TESTERX').last) {
                  Uint8List u8 = base64Decode(el.split('TESTERX').last);
                  return Image.memory(
                    u8,
                    height: 50,
                    fit: BoxFit.contain,
                  );
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
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/presentation/test/test.dart';

class FinishDialogWidget extends StatefulWidget {
  const FinishDialogWidget({
    super.key,
    required this.bloc,
  });

  final TestBloc bloc;

  @override
  State<FinishDialogWidget> createState() => _FinishDialogWidgetState();
}

class _FinishDialogWidgetState extends State<FinishDialogWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return CupertinoAlertDialog(
      title: const Text('Вы уверены что хотите закончить тест?'),
      actions: [
        CupertinoDialogAction(
          child: Text(
            'Да',
            style: TextStyle(
              color: isLoading ? Colors.grey : theme.primaryColor,
            ),
          ),
          onPressed: () {
            setState(() {
              isLoading = true;
            });
            widget.bloc.add(OnTestFinish());
          },
        ),
        CupertinoDialogAction(
          child: const Text('Нет'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

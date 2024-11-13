import 'package:flutter/material.dart';
import 'package:testerx2/presentation/widgets/widgets.dart';
import 'package:testerx2/repository/repository.dart';

class EditNameWidget extends StatefulWidget {
  const EditNameWidget({
    super.key,
    required this.beforeName,
  });
  final String beforeName;

  @override
  State<EditNameWidget> createState() => _EditNameWidgetState();
}

class _EditNameWidgetState extends State<EditNameWidget> {
  var textController = TextEditingController();
  var buttonLoading = false;

  @override
  void initState() {
    textController.text = widget.beforeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    submit() async {
      setState(() {
        buttonLoading = true;
      });
      await AuthRepository().setUserDisplayName(textController.text.trim());
      setState(() {
        buttonLoading = false;
      });
      if (context.mounted) {
        Navigator.pop(context);
      }
    }

    return Material(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        height: 300,
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Изменить имя',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 30),
            PrimaryInput(
              controller: textController,
              hintText: 'Название отображаемого имени',
              obscureText: false,
              focusNode: FocusNode(),
              onSubmitted: (p0) {
                submit();
              },
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              onTap: submit,
              isLoading: buttonLoading,
              child: const Text(
                'Изменить',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/ui/ui.dart';

class AddTest extends StatelessWidget {
  const AddTest({super.key});

  @override
  Widget build(BuildContext context) {
    addToDbFromFile(BuildContext context, String groupId) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        if (!context.mounted) return false;
        Navigator.of(context).pop();
        var file = File(result.files.single.path!);
        showCupertinoModalBottomSheet(
          context: context,
          builder: (context) {
            return AddTestByWordAndAskName(file: file, groupId: groupId);
          },
        );
      }
    }

    return GestureDetector(
      child: const PrimaryListWidget(
        text: 'Добавить тест',
        rightWidget:
            Icon(Icons.note_add_outlined, color: Colors.black, size: 26),
      ),
      onTap: () async {
        AuthModel? user = await AuthRepository().getUser();
        String? groupId = user!.groupId;
        if (!context.mounted) return;
        if (groupId == null) {
          return showCupertinoModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                height: 200 + MediaQuery.of(context).viewInsets.bottom,
                child: const Scaffold(
                  body: Center(
                    child: Text(
                      'Выберите сначала свою группу',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              );
            },
          );
        }
        showCupertinoModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: 200 + MediaQuery.of(context).viewInsets.bottom,
              child: Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      children: [
                        const Text(
                          'Добавить тест',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimaryButton(
                              onTap: () {},
                              height: 70,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 45),
                              child: const Text(
                                'Вручную',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                            PrimaryButton(
                              onTap: () {
                                addToDbFromFile(context, groupId);
                              },
                              height: 70,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 45),
                              child: const Text(
                                'Через ворд',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class AddTestByWordAndAskName extends StatefulWidget {
  const AddTestByWordAndAskName({
    super.key,
    required this.file,
    required this.groupId,
  });

  final File file;
  final String groupId;

  @override
  State<AddTestByWordAndAskName> createState() =>
      _AddTestByWordAndAskNameState();
}

class _AddTestByWordAndAskNameState extends State<AddTestByWordAndAskName> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270 + MediaQuery.of(context).viewInsets.bottom,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            const Text(
              'Введите название теста',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            PrimaryInput(
              controller: nameController,
              hintText: 'Название',
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              onTap: () async {
                if (isLoading) return null;
                setState(() {
                  isLoading = true;
                });
                await TestRepository().addTest(
                  widget.file,
                  nameController.text.trim(),
                  widget.groupId,
                );
                setState(() {
                  isLoading = false;
                });
                if (!context.mounted) return false;
                Navigator.of(context).pop();
              },
              child: !isLoading
                  ? const Text(
                      'Добавить',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  : const CircularProgressIndicator(),
            )
          ]),
        ),
      ),
    );
  }
}

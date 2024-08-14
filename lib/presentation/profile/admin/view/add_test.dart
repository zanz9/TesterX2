import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testerx2/ui/ui.dart';

class AddTest extends StatelessWidget {
  const AddTest({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const PrimaryListWidget(
        text: 'Добавить тест',
        rightWidget:
            Icon(Icons.note_add_outlined, color: Colors.black, size: 26),
      ),
      onTap: () {
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
                              onTap: () {},
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

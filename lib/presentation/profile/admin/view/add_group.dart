import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testerx2/presentation/profile/admin/admin.dart';
import 'package:testerx2/ui/ui.dart';

class AddGroup extends StatelessWidget {
  const AddGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AdminBloc>();
        showCupertinoModalBottomSheet(
          duration: const Duration(milliseconds: 300),
          context: context,
          builder: (context) => Material(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 300,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Добавить группу',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 30),
                  PrimaryInput(
                    controller: TextEditingController(),
                    hintText: 'Название группы',
                    obscureText: false,
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton(
                    isLoading: false,
                    onTap: () {},
                    text: 'Добавить',
                  )
                ],
              ),
            ),
          ),
        );
      },
      child: const PrimaryListWidget(
        text: 'Добавить группу',
      ),
    );
  }
}

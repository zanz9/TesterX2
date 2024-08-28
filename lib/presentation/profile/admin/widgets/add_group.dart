import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testerx2/presentation/profile/admin/admin.dart';
import 'package:testerx2/presentation/widgets/widgets.dart';

class AddGroup extends StatelessWidget {
  const AddGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final groupNameController = TextEditingController();
    return GestureDetector(
      child: const PrimaryListWidget(
        text: 'Добавить группу',
        rightWidget:
            Icon(Icons.group_add_outlined, color: Colors.black, size: 26),
      ),
      onTap: () {
        showCupertinoModalBottomSheet(
          duration: const Duration(milliseconds: 300),
          context: context,
          builder: (context) {
            var bloc = AddGroupBloc();
            return BlocBuilder<AddGroupBloc, AddGroupState>(
              bloc: bloc,
              builder: (context, state) {
                String text = 'Добавить группу';
                if (state is AddGroupInitial) {
                  text = 'Добавить группу';
                }
                if (state is AddGroupFail) {
                  text = 'Произошла ошибка';
                } else if (state is AddGroupSuccess) {
                  Navigator.pop(context);
                  groupNameController.clear();
                }
                return Material(
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    height: 300 + MediaQuery.of(context).viewInsets.bottom,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          text,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 30),
                        PrimaryInput(
                          controller: groupNameController,
                          hintText: 'Название группы',
                          obscureText: false,
                          focusNode: FocusNode(),
                        ),
                        const SizedBox(height: 30),
                        PrimaryButton(
                          onTap: () {
                            if (state is! AddGroupLoading) {
                              bloc.add(
                                  OnAddGroup(name: groupNameController.text));
                            }
                          },
                          onTapOutside: () {
                            if (state is! AddGroupLoading) {
                              bloc.add(OnUpdateAddGroup());
                            }
                          },
                          isLoading: state is AddGroupLoading,
                          child: const Text(
                            'Добавить',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

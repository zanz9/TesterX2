import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/presentation.dart';
import 'package:testerx2/presentation/test/test_edit/bloc/test_edit_bloc.dart';

@RoutePage()
class TestEditScreen extends StatelessWidget {
  const TestEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = TestEditBloc()..add(OnTestEdit());
    return BlocProvider.value(
      value: bloc,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(
                  top: 16, left: 16, right: 16, bottom: 10),
              children: [
                const Text(
                  'Название теста:',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 8),
                PrimaryInput(
                  controller: bloc.testTitleController,
                  hintText: 'Название теста',
                ),
                BlocBuilder<TestEditBloc, TestEditState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return TestEditLabelWithInput(
                      controller: bloc.questionTitleController,
                      labelText: 'Вопрос - ${bloc.testIndex + 1}',
                      hindText: 'Вопрос',
                    );
                  },
                ),
                BlocBuilder<TestEditBloc, TestEditState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bloc.answerControllers.length,
                      itemBuilder: (context, index) {
                        return TestEditLabelWithInput(
                          controller: bloc.answerControllers[index],
                          labelText: 'Ответ - ${index + 1}',
                          hindText: 'Ответ',
                          isAnswer: true,
                          onCheck: () {},
                          onDelete: () => bloc.add(
                            OnTestEditAnswerDelete(index: index),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 32),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => bloc.add(OnTestEditAnswerAdd()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          '+ Добавить ответ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 72,
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: IconButton(
                        onPressed: () {
                          bloc.add(OnTestEditQuestionPrev());
                        },
                        icon: const Icon(Icons.arrow_back))),
                Expanded(
                    child: PrimaryButton(
                        padding: EdgeInsets.zero,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        onTap: () {},
                        isLoading: false,
                        child: const Text('Сохранить тест',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)))),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: IconButton(
                        onPressed: () {
                          bloc.add(OnTestEditQuestionNext());
                        },
                        icon: const Icon(Icons.arrow_forward)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TestEditLabelWithInput extends StatefulWidget {
  const TestEditLabelWithInput({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hindText,
    this.isAnswer = false,
    this.onCheck,
    this.onDelete,
  });

  final TextEditingController controller;
  final String labelText;
  final String hindText;
  final bool isAnswer;
  final Function()? onCheck;
  final Function()? onDelete;

  @override
  State<TestEditLabelWithInput> createState() => _TestEditLabelWithInputState();
}

class _TestEditLabelWithInputState extends State<TestEditLabelWithInput> {
  bool isChecked = false;
  late final FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode()..addListener(onFocusChange);
    super.initState();
  }

  void onFocusChange() {
    if (!focusNode.hasFocus) {
      context.read<TestEditBloc>().add(OnTestEditSave());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          widget.labelText,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        PrimaryInput(
          autoFocus: false,
          focusNode: focusNode,
          controller: widget.controller,
          hintText: widget.hindText,
          prefixIcon: widget.isAnswer
              ? MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() => isChecked = !isChecked);
                      widget.onCheck?.call();
                    },
                    child: Icon(isChecked
                        ? Icons.check_box
                        : Icons.check_box_outline_blank),
                  ),
                )
              : null,
          suffixIcon: widget.isAnswer
              ? MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: widget.onDelete,
                    child: const Icon(Icons.cancel),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}

import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:testerx2/core/di/init_di.dart';
import 'package:testerx2/core/router/router.dart';
import 'package:testerx2/presentation/home/home.dart';
import 'package:testerx2/presentation/widgets/widgets.dart';
import 'package:testerx2/repository/repository.dart';

class TestPreview extends StatefulWidget {
  const TestPreview({super.key, required this.test});
  final TestModel test;

  @override
  State<TestPreview> createState() => _TestPreviewState();
}

class _TestPreviewState extends State<TestPreview> {
  final bloc = TestPreviewBloc();
  @override
  void initState() {
    bloc.add(OnTestPreview(test: widget.test));
    super.initState();
  }

  double sliderValue = 25;
  TextEditingController textController = TextEditingController()..text = '25';

  bool backButtonLoading = false;
  bool startButtonLoading = false;

  showAccessDialog(BuildContext context) async {
    List<AuthModel> users = await getIt<AuthRepository>().getUsers();
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => AccessDialog(
        accessList: widget.test.accessList ?? [],
        users: users,
        testId: widget.test.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<TestPreviewBloc, TestPreviewState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is TestPreviewLoaded) {
          setState(() {
            var value = state.test.tests.length.toDouble() < 25
                ? state.test.tests.length.toDouble()
                : 25.0;
            sliderValue = value;
            textController.text = value.toInt().toString();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          widget.test.name,
                          style: const TextStyle(fontSize: 36),
                        ),
                      ),
                      widget.test.authorId == getIt<AuthRepository>().getMyUid()
                          ? IconButton(
                              onPressed: () {
                                bloc.add(
                                  OnTestPreviewDelete(test: widget.test),
                                );
                                context.router.maybePop();
                              },
                              icon: const Icon(Icons.delete_outline),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (state is TestPreviewError)
                    Column(
                      children: [
                        const Center(
                          child: Text(
                            'У вас нет доступа к этому тесту',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          onTap: () => context.router.maybePop(),
                          isLoading: false,
                          outlined: true,
                          child: const Text('Назад'),
                        ),
                      ],
                    ),
                  if (state is TestPreviewLoading)
                    Column(
                      children: [
                        const Center(child: CircularProgressIndicator()),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          onTap: () => context.router.maybePop(),
                          isLoading: false,
                          outlined: true,
                          child: const Text('Назад'),
                        ),
                      ],
                    ),
                  if (state is TestPreviewLoaded)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 80,
                              child: PrimaryInput(
                                controller: textController,
                                hintText: 'Кол-во',
                                keyboardType: TextInputType.number,
                                onChange: (value) {
                                  setState(() {
                                    String val = value;
                                    if (int.parse(val) >
                                        state.test.tests.length) {
                                      val = state.test.tests.length.toString();
                                      textController.text = val;
                                    } else if (int.parse(val) < 0) {
                                      val = 0.toString();
                                      textController.text = val;
                                    }
                                    sliderValue = int.parse(val).toDouble();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SfSlider(
                          min: 0,
                          max: state.test.tests.length,
                          value: sliderValue,
                          onChanged: (value) {
                            setState(() {
                              sliderValue = value;
                              textController.text = value.round().toString();
                            });
                          },
                          interval: 25,
                          showTicks: true,
                          showLabels: true,
                          showDividers: false,
                          enableTooltip: false,
                          shouldAlwaysShowTooltip: false,
                          stepSize: 1,
                          activeColor: theme.primaryColor,
                          inactiveColor: Colors.grey.shade100,
                        ),
                        const SizedBox(height: 45),
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                onTap: () async {
                                  setState(() {
                                    backButtonLoading = true;
                                  });
                                  Navigator.pop(context);
                                  setState(() {
                                    backButtonLoading = false;
                                  });
                                },
                                isLoading: backButtonLoading,
                                outlined: true,
                                child: const Text(
                                  'Отмена',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: PrimaryButton(
                                isLoading: startButtonLoading,
                                onTap: () async {
                                  setState(() {
                                    startButtonLoading = true;
                                  });
                                  List<TestFileModel> tests = widget.test.tests;
                                  tests.shuffle();
                                  tests.length = sliderValue.toInt();
                                  tests.map((e) => e.body.shuffle()).toList();
                                  setState(() {
                                    startButtonLoading = false;
                                  });
                                  await GetIt.I<SharedPreferences>().setString(
                                      'testModel',
                                      jsonEncode(
                                          widget.test.toJsonAllFields()));
                                  await GetIt.I<SharedPreferences>()
                                      .setInt('testIndex', 0);
                                  await GetIt.I<SharedPreferences>()
                                      .remove('testFinish');
                                  GetIt.I<AppRouter>()
                                      .replace(const TestPageRoute());
                                },
                                child: const Text(
                                  'Начать тест',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        if (bloc.isAdmin)
                          Row(
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  outlined: true,
                                  isLoading: false,
                                  onTap: () {
                                    showAccessDialog(context);
                                  },
                                  child: const Text(
                                    'Управление доступом',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AccessDialog extends StatefulWidget {
  const AccessDialog({
    super.key,
    required this.accessList,
    required this.users,
    required this.testId,
  });

  final List accessList;
  final List<AuthModel> users;
  final String testId;
  @override
  State<AccessDialog> createState() => _AccessDialogState();
}

class _AccessDialogState extends State<AccessDialog> {
  String? selectedUser;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Управление доступом'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Доступ к тесту имеют:'),
          for (var uid in widget.accessList)
            Text(widget.users.firstWhere((e) => e.uid == uid).displayName),
          const Text('Добавить в доступ:'),
          DropdownButton(
            items: widget.users
                .map((e) => DropdownMenuItem(
                    value: e.uid, child: Text('${e.displayName} - ${e.uid}')))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedUser = value;
              });
            },
            value: selectedUser,
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            onTap: () {
              if (selectedUser == null) return;
              getIt<TestRepository>()
                  .addUserToAccessList(widget.testId, selectedUser!);
              Navigator.pop(context);
            },
            isLoading: false,
            outlined: false,
            child: const Text(
              'Добавить',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Закрыть'),
        ),
      ],
    );
  }
}

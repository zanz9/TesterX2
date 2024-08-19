import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/new_home/new_home.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/ui.dart';

class NewTestPreview extends StatefulWidget {
  const NewTestPreview({super.key, required this.test});
  final TestModel test;

  @override
  State<NewTestPreview> createState() => _NewTestPreviewState();
}

class _NewTestPreviewState extends State<NewTestPreview> {
  final bloc = TestPreviewBloc();
  @override
  void initState() {
    bloc.add(OnTestPreview(test: widget.test));
    super.initState();
  }

  double sliderValue = 25;
  TextEditingController textController = TextEditingController()..text = '25';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<TestPreviewBloc, TestPreviewState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    widget.test.name,
                    style: const TextStyle(fontSize: 36),
                  ),
                  const SizedBox(height: 20),
                  if (state is TestPreviewLoading)
                    const Center(child: CircularProgressIndicator()),
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
                                    sliderValue = int.parse(value).toDouble();
                                    textController.text =
                                        int.tryParse(value).toString();
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
                                onTap: () {
                                  Navigator.pop(context);
                                },
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
                                child: const Text(
                                  'Начать тест',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  List<TestFileModel> tests = widget.test.tests;
                                  tests.shuffle();
                                  tests.length = sliderValue.toInt();
                                  tests.map((e) => e.body.shuffle()).toList();
                                  context.router.replace(
                                    NewTestRoute(testModel: widget.test),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
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
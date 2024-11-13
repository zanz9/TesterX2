import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/presentation/widgets/widgets.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/core/router/router.dart';
import 'package:intl/intl.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({
    super.key,
    required this.history,
  });
  final List<HistoryModel> history;

  @override
  Widget build(BuildContext context) {
    return history.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              const Text(
                'История',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: history.length,
                itemBuilder: (context, index) {
                  HistoryModel data = history[index];
                  String timestamp =
                      DateFormat('HH:mm dd-MM-yyyy').format(data.timestamp);

                  return HistoryListWidget(data: data, timestamp: timestamp);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
            ],
          );
  }
}

class HistoryListWidget extends StatefulWidget {
  const HistoryListWidget({
    super.key,
    required this.data,
    required this.timestamp,
  });

  final HistoryModel data;
  final String timestamp;

  @override
  State<HistoryListWidget> createState() => _HistoryListWidgetState();
}

class _HistoryListWidgetState extends State<HistoryListWidget> {
  bool isPressed = false;

  openHistoryTest() async {
    if (widget.data.test == null) return;
    if (isPressed) return;
    setState(() {
      isPressed = true;
    });
    widget.data.test!.tests = await GetIt.I<StorageRepository>()
        .downloadHistory(widget.data.pathHistory);
    setState(() {
      isPressed = false;
    });
    await GetIt.I<SharedPreferences>().setString(
        'testModel', jsonEncode(widget.data.test!.toJsonAllFields()));
    await GetIt.I<SharedPreferences>().setBool('testFinish', true);
    GetIt.I<AppRouter>().push(const TestFinishRoute());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: openHistoryTest,
      child: PrimaryListWidget(
        text: widget.data.test == null
            ? 'Этот тест был удален'
            : widget.data.test!.name,
        secondaryText: widget.timestamp,
        disabled: widget.data.test == null,
        rightWidget: isPressed
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(color: Colors.black))
            : Icon(
                Icons.chevron_right_rounded,
                color: widget.data.test == null ? Colors.grey : Colors.black,
                size: 36,
              ),
      ),
    );
  }
}

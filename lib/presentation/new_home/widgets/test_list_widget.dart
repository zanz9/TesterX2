import 'package:flutter/material.dart';

class TestListWidget extends StatelessWidget {
  const TestListWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      height: 54,
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
          const Spacer(),
          const Icon(
            Icons.chevron_right_rounded,
            color: Colors.black,
            size: 36,
          ),
        ],
      ),
    );
  }
}

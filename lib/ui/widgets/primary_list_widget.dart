import 'package:flutter/material.dart';

class PrimaryListWidget extends StatelessWidget {
  const PrimaryListWidget({
    super.key,
    required this.text,
    this.rightWidget = const Icon(
      Icons.chevron_right_rounded,
      color: Colors.black,
      size: 36,
    ),
    this.secondaryText,
  });
  final String text;
  final String? secondaryText;
  final Widget rightWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      height: secondaryText == null ? 54 : 72,
      child: Row(
        children: [
          secondaryText == null
              ? Text(
                  text,
                  style: const TextStyle(fontSize: 18),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      secondaryText!,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
          const Spacer(),
          rightWidget,
        ],
      ),
    );
  }
}

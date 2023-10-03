import 'package:flutter/material.dart';

class TestChooseButton extends StatelessWidget {
  const TestChooseButton({
    super.key,
    required this.icon,
    required this.onTap,
  });
  final Icon icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Material(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            highlightColor: Colors.black12,
            splashColor: Colors.black12,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

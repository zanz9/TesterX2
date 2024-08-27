import 'package:flutter/material.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';

class LockIconWithAnimation extends StatelessWidget {
  const LockIconWithAnimation({
    super.key,
    required this.shakeKey,
    required this.color,
  });

  final GlobalKey<ShakeWidgetState> shakeKey;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ShakeMe(
      key: shakeKey,
      shakeCount: 3,
      shakeOffset: 10,
      shakeDuration: const Duration(milliseconds: 500),
      child: Icon(
        Icons.lock,
        color: color,
        size: 100,
      ),
    );
  }
}

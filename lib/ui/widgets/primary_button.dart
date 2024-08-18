import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;
  final Function()? onTapOutside;
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final double? height;
  final bool outlined;

  const PrimaryButton({
    super.key,
    required this.onTap,
    this.onTapOutside,
    required this.child,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(vertical: 20),
    this.height,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapInside: (event) {
        onTap();
      },
      onTapOutside: (event) {
        if (onTapOutside != null) onTapOutside!();
      },
      child: Container(
        padding: padding,
        height: height,
        decoration: BoxDecoration(
          color: outlined ? Colors.transparent : Colors.black,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: outlined ? Colors.black : Colors.transparent,
          ),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

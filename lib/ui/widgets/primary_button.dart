import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;
  final Function()? onTapOutside;
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final double? height;

  const PrimaryButton({
    super.key,
    required this.onTap,
    this.onTapOutside,
    required this.child,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(vertical: 20),
    this.height,
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
          color: Colors.black,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

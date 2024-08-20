import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;
  final bool isLoading;
  final Function()? onTapOutside;
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final double? height;
  final bool outlined;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.isLoading,
    this.onTapOutside,
    required this.child,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(vertical: 20),
    this.height,
    this.outlined = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    if (outlined) {
      if (isLoading) {
        color = Colors.grey;
      } else {
        color = Colors.transparent;
      }
    } else {
      if (isLoading) {
        color = Colors.grey;
      } else {
        color = Colors.black;
      }
    }
    return TapRegion(
      onTapInside: (event) {
        onTap();
      },
      onTapOutside: (event) {
        if (onTapOutside != null) onTapOutside!();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: padding,
        margin: margin,
        height: height,
        decoration: BoxDecoration(
          color: color,
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

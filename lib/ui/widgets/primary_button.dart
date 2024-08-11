import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;
  final Function()? onTapOutside;
  final String text;
  final bool isLoading;
  final double fontSize;
  final double borderRadius;
  final EdgeInsets padding;

  const PrimaryButton({
    super.key,
    required this.onTap,
    this.onTapOutside,
    required this.text,
    required this.isLoading,
    this.fontSize = 16,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(vertical: 20),
  });

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapInside: (event) {
        if (!isLoading) onTap();
      },
      onTapOutside: (event) {
        if (onTapOutside != null) if (!isLoading) onTapOutside!();
      },
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: fontSize + 5,
                  width: fontSize + 5,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
        ),
      ),
    );
  }
}

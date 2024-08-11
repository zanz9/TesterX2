import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;
  final Function()? onTapOutside;
  final String text;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.onTap,
    this.onTapOutside,
    required this.text,
    required this.isLoading,
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
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 21,
                  width: 21,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}

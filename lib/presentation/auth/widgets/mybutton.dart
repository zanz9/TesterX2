import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function() onTapInside;
  final Function() onTapOutside;
  final String text;
  final bool isLoading;

  const MyButton({
    super.key,
    required this.onTapInside,
    required this.onTapOutside,
    required this.text,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapInside: (event) {
        onTapInside();
      },
      onTapOutside: (event) {
        onTapOutside();
      },
      // onTap: onTap,
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

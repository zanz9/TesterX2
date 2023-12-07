import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  const SignButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.loading,
  });
  final String text;
  final Function() onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(18),
      color: Colors.white,
      child: InkWell(
        highlightColor: theme.splashColor,
        splashColor: theme.splashColor,
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 60,
          ),
          child: loading
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
        ),
      ),
    );
  }
}

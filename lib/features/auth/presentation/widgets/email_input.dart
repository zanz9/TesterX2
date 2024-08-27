import 'package:flutter/material.dart';
import 'package:testerx2/ui/ui.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
    required this.emailController,
    this.onSubmitted,
  });
  final TextEditingController emailController;
  final Function()? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return PrimaryInput(
      controller: emailController,
      hintText: 'Почта',
      obscureText: false,
      onSubmitted: (p0) {
        if (onSubmitted != null) onSubmitted!();
      },
      prefixIcon: const Icon(Icons.email_rounded),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

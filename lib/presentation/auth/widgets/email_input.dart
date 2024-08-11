import 'package:flutter/material.dart';
import 'package:testerx2/ui/ui.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
    required this.emailController,
  });
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return PrimaryInput(
      controller: emailController,
      hintText: 'Почта',
      obscureText: false,
      prefixIcon: const Icon(Icons.email_rounded),
    );
  }
}

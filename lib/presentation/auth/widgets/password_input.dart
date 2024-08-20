import 'package:flutter/material.dart';
import 'package:testerx2/ui/ui.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
    required this.passwordController,
    this.isSecond = false,
  });
  final TextEditingController passwordController;
  final bool isSecond;

  @override
  Widget build(BuildContext context) {
    return PrimaryInput(
      controller: passwordController,
      hintText: !isSecond ? 'Пароль' : 'Повторите пароль',
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: const RotatedBox(
        quarterTurns: 1,
        child: Icon(Icons.key_outlined),
      ),
    );
  }
}

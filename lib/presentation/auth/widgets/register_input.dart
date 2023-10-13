import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.labelHide,
    required this.controller,
    this.isSecond = false,
  });
  final bool labelHide;
  final bool isSecond;
  final TextEditingController controller;

  @override
  State<PasswordInput> createState() => _PasswordLabelState();
}

class _PasswordLabelState extends State<PasswordInput> {
  bool isHide = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.labelHide)
          Text(!widget.isSecond ? 'Пароль' : 'Повторите пароль'),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6.0,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: isHide,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: !widget.isSecond ? 'Пароль' : 'Повторите пароль',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isHide = !isHide;
                  });
                },
                icon: const Icon(Icons.remove_red_eye),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

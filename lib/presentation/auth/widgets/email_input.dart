import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
    required this.labelHide,
    required this.controller,
  });
  final bool labelHide;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!labelHide) const Text('Email'),
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
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: 'Email',
            ),
          ),
        ),
      ],
    );
  }
}

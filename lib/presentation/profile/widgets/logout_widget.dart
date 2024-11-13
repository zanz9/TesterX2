import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/core/router/router.dart';

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({
    super.key,
  });

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() => isHovering = true),
      onExit: (event) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: () async {
          await AuthRepository().logout();
          GetIt.I<AppRouter>()
              .replaceAll([const HomeRoute(), const LoginRoute()]);
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isHovering ? Colors.grey : Colors.transparent,
            ),
          ),
          duration: const Duration(milliseconds: 300),
          child: const Row(
            children: [
              Icon(Icons.logout_rounded, color: Colors.black),
              SizedBox(width: 4),
              Text(
                'Выйти с аккаунта',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}

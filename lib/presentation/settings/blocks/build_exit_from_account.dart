import 'package:flutter/material.dart';
import 'package:testerx2/presentation/auth/service/auth_service.dart';
import 'package:testerx2/ui/ui.dart';

class BuildExitFromAccount extends StatelessWidget {
  const BuildExitFromAccount({super.key});

  Future<void> signOut() async {
    await AuthService.logout();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: ListContainer(
        bodyText: 'Выйти из аккаунта',
        rightSide: Icon(
          Icons.exit_to_app,
          color: theme.hintColor,
        ),
        onTap: () {
          signOut();
        },
      ),
    );
  }
}

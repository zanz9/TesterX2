import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/presentation/profile/profile.dart';
import 'package:testerx2/repository/auth/auth_repository.dart';
import 'package:testerx2/router/router.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        actions: [
          GestureDetector(
            onTap: () async {
              await AuthRepository().logout();
              GetIt.I<AppRouter>().replace(LoginRoute());
            },
            child: const Row(
              children: [
                Icon(Icons.logout_rounded, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  'Выйти с аккаунта',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 16),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const SizedBox(height: 30),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 48),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: const Column(
                        children: [
                          SizedBox(height: 50),
                          Text(
                            'Бауыржан',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 30),
                          UserGroupWidget()
                        ],
                      ),
                    ),
                    const UserAvatarWithCamera(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

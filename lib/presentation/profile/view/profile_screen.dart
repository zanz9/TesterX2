import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testerx2/presentation/presentation.dart';
import 'package:testerx2/repository/auth/auth_repository.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/ui.dart';

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
              GetIt.I<AppRouter>().replaceAll([const LoginRoute()]);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
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
                ),
                const SizedBox(height: 30),
                const Text(
                  'Админка',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      duration: const Duration(milliseconds: 300),
                      context: context,
                      builder: (context) => Material(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 300,
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              const Text(
                                'Добавить группу',
                                style: TextStyle(fontSize: 24),
                              ),
                              const SizedBox(height: 30),
                              PrimaryInput(
                                controller: TextEditingController(),
                                hintText: 'Название группы',
                                obscureText: false,
                              ),
                              const SizedBox(height: 30),
                              PrimaryButton(
                                isLoading: false,
                                onTap: () {},
                                text: 'Добавить',
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: const PrimaryListWidget(
                    text: 'Добавить группу',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

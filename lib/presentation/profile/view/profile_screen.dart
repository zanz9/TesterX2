import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/presentation/profile/profile.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

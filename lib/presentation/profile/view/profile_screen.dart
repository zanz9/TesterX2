import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/repository/auth/auth_repository.dart';
import 'package:testerx2/repository/group/group_repository.dart';

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
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 48),
                      height: 300,
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
                          SizedBox(height: 10),
                          UserGroupWidget()
                        ],
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 38.0,
                            backgroundImage: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s'),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 12.0,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 15.0,
                                  color: Color(0xFF404040),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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

class UserGroupWidget extends StatefulWidget {
  const UserGroupWidget({
    super.key,
  });

  @override
  State<UserGroupWidget> createState() => _UserGroupWidgetState();
}

class _UserGroupWidgetState extends State<UserGroupWidget> {
  String userGroup = '';

  @override
  void initState() {
    AuthRepository().getUser().then((v) {
      if (v != null) {
        GroupRepository().getGroup(v.groupId).then((value) {
          setState(() {
            userGroup = value!;
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            'Группа: $userGroup',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          const Row(
            children: [
              Text(
                'Сменить группу',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 16,
              )
            ],
          )
        ],
      ),
    );
  }
}

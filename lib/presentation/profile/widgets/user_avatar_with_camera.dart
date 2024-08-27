// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:random_avatar/random_avatar.dart';

class UserAvatarWithCamera extends StatelessWidget {
  const UserAvatarWithCamera({
    super.key,
    required this.username,
  });
  final String username;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        child: CircleAvatar(
          radius: 40.0,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 38.0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                SvgPicture.string(
                  RandomAvatarString(username),
                  width: 76.0,
                  height: 76.0,
                  fit: BoxFit.cover,
                ),
                const Align(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

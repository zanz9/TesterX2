import 'package:flutter/material.dart';

class UserAvatarWithCamera extends StatelessWidget {
  const UserAvatarWithCamera({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
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
    );
  }
}

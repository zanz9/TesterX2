import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/router/router.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SliverAppBar(
      floating: true,
      snap: false,
      pinned: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: theme.scaffoldBackgroundColor,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Добро пожаловать,',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
                const Text(
                  'Бауыржан',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                context.router.push(const MainRoute());
              },
              icon: const Icon(
                Icons.person,
                size: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

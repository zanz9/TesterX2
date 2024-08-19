import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/new_home/new_home.dart';
import 'package:testerx2/router/router.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SliverAppBar(
      floating: false,
      snap: false,
      pinned: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: theme.scaffoldBackgroundColor,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Добро пожаловать,',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                    if (state is HomeTestsLoaded)
                      Text(
                        state.user.displayName == ''
                            ? 'Пользователь'
                            : state.user.displayName ?? 'Пользователь',
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                  ],
                );
              },
            ),
            IconButton(
              onPressed: () async {
                await context.router.push(const ProfileRoute());
                if (context.mounted) context.read<HomeBloc>().add(OnHome());
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

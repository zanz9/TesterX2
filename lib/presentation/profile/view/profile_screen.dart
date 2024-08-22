import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testerx2/presentation/presentation.dart';
import 'package:testerx2/repository/auth/auth_repository.dart';
import 'package:testerx2/router/router.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var bloc = ProfileBloc();
    bloc.add(OnProfile());

    editName(String beforeName) async {
      var result = await showCupertinoModalBottomSheet(
        duration: const Duration(milliseconds: 300),
        context: context,
        builder: (context) {
          return EditNameWidget(
            beforeName: beforeName,
          );
        },
      );
      if (result == null) {
        bloc.add(OnProfile());
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: theme.scaffoldBackgroundColor,
        actions: [
          GestureDetector(
            onTap: () async {
              await AuthRepository().logout();
              GetIt.I<AppRouter>().replaceAll([const LoginRoute()]);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
              ),
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
                BlocProvider(
                  create: (context) => bloc,
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      String displayName = 'Пользователь';
                      if (state is ProfileLoaded) {
                        displayName = state.user.displayName == ''
                            ? 'Пользователь'
                            : state.user.displayName ?? 'Пользователь';
                      }
                      return Stack(
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
                            child: Column(
                              children: [
                                const SizedBox(height: 50),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      displayName,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        editName(state is ProfileLoaded
                                            ? state.user.displayName ?? ''
                                            : '');
                                      },
                                      icon: const Icon(Icons.edit),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 30),
                                const UserGroupWidget()
                              ],
                            ),
                          ),
                          const UserAvatarWithCamera(),
                        ],
                      );
                    },
                  ),
                ),
                const AdminWidgets(),
                if (kDebugMode)
                  const Column(
                    children: [
                      SizedBox(height: 30),
                      DevWidgets(),
                    ],
                  ),
                const SizedBox(height: 30),
                BlocBuilder<ProfileBloc, ProfileState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is ProfileLoaded) {
                      return HistoryWidget(history: state.history);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Version: v1.1.3'),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

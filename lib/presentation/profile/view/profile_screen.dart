import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testerx2/core/router/router.dart';
import 'package:testerx2/presentation/home/home.dart';
import 'package:testerx2/presentation/profile/profile.dart';
import 'package:testerx2/presentation/widgets/widgets.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var bloc = GetIt.I<HomeBloc>()..add(OnHome());

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
        bloc.add(OnHome());
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: theme.scaffoldBackgroundColor,
        leading: BackButton(
          onPressed: () async {
            bool canPop = await context.router.maybePop(true);
            if (!canPop && context.mounted) {
              context.router.replaceAll([const HomeRoute()]);
            }
          },
        ),
        automaticallyImplyLeading: true,
        actions: const [LogoutWidget(), SizedBox(width: 16)],
      ),
      body: GestureDetector(
        onPanEnd: (details) async {
          int direction = 3;
          if (details.velocity.pixelsPerSecond.dx > direction) {
            bool canPop = await context.router.maybePop(true);
            if (!canPop && context.mounted) {
              context.router.replaceAll([const HomeRoute()]);
            }
          }
        },
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  BlocBuilder<HomeBloc, HomeState>(
                    bloc: bloc,
                    builder: (context, state) {
                      String displayName = 'Пользователь';
                      String getDisplayName(String? displayName) {
                        return displayName == ''
                            ? 'Пользователь'
                            : displayName ?? 'Пользователь';
                      }

                      if (state is HomeTestsLoaded) {
                        displayName = getDisplayName(state.user.displayName);
                      } else if (state is HomeUserGroupNotHaveTests) {
                        displayName = getDisplayName(state.user.displayName);
                      } else if (state is HomeUserNotHaveGroup) {
                        displayName = getDisplayName(state.user.displayName);
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
                                        editName(displayName);
                                      },
                                      icon: const Icon(Icons.edit),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const UserGroupWidget()
                              ],
                            ),
                          ),
                          UserAvatarWithCamera(
                            username: displayName,
                          ),
                        ],
                      );
                    },
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
                    bloc: ProfileBloc()..add(OnProfile()),
                    builder: (context, state) {
                      if (state is ProfileLoaded) {
                        return HistoryWidget(history: state.history);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  const VersionWidget(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/models/index.dart';
import 'package:testerx2/presentation/presentation.dart';
import 'package:testerx2/router/guard.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: NewHomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: ProfileRoute.page,
          path: '/profile',
        ),
        AutoRoute(page: HomeRoute.page, path: '/', children: [
          AutoRoute(
            path: 'old_home',
            page: MainRoute.page,
          ),
          AutoRoute(
            path: 'history',
            page: HistoryRoute.page,
          ),
          AutoRoute(
            path: 'settings',
            page: SettingsRoute.page,
          ),
        ], guards: [
          AuthGuard()
        ]),
        AutoRoute(
          path: '/test_preview',
          page: TestPreviewRoute.page,
        ),
        AutoRoute(
          path: '/test',
          page: TestPageRoute.page,
        ),
        AutoRoute(
          path: '/test_finish',
          page: TestFinishRoute.page,
        ),
        CustomRoute(
          path: '/login',
          page: LoginRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 150,
        ),
        CustomRoute(
          path: '/register',
          page: RegisterRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 150,
        ),
        CustomRoute(
          path: '/forget_password',
          page: ForgetPasswordRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeft,
          durationInMilliseconds: 300,
        ),
      ];
}

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
          guards: [AuthGuard()],
        ),
        CustomRoute(
          page: ProfileRoute.page,
          path: '/profile',
          transitionsBuilder: TransitionsBuilders.slideLeft,
          durationInMilliseconds: 300,
          guards: [AuthGuard()],
        ),
        AutoRoute(page: HomeRoute.page, path: '/old', children: [
          AutoRoute(
            path: '',
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

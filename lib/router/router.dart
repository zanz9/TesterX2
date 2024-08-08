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
        AutoRoute(page: HomeRoute.page, path: '/', children: [
          AutoRoute(
            path: '',
            page: MainRoute.page,
            initial: true,
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
        AutoRoute(
          path: '/login',
          page: LoginRoute.page,
          keepHistory: false,
        ),
        AutoRoute(
          path: '/register',
          page: RegisterRoute.page,
        )
      ];
}

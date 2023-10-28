import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/models/index.dart';
import 'package:testerx2/presentation/auth/login/login.dart';
import 'package:testerx2/presentation/auth/register/register.dart';

import 'package:testerx2/presentation/history/history.dart';
import 'package:testerx2/presentation/home/home.dart';
import 'package:testerx2/presentation/main/main.dart';
import 'package:testerx2/presentation/settings/settings.dart';
import 'package:testerx2/presentation/test/models/progress.dart';
import 'package:testerx2/presentation/test/test.dart';
import 'package:testerx2/presentation/test_editor/view/index.dart';
import 'package:testerx2/presentation/test_finish/test_finish.dart';
import 'package:testerx2/presentation/test_preview/test_preview.dart';
import 'package:testerx2/router/guard.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
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
          page: TestEditorRoute.page,
        ),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: RegisterRoute.page,
        )
      ];
}

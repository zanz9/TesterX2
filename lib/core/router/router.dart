import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:testerx2/core/router/guard.dart';
import 'package:testerx2/presentation/presentation.dart';

part 'router.gr.dart';

@Singleton()
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: HomeRoute.page,
          guards: [AuthGuard()],
        ),
        CustomRoute(
          page: ProfileRoute.page,
          path: '/profile',
          transitionsBuilder: TransitionsBuilders.slideLeft,
          durationInMilliseconds: 300,
          guards: [AuthGuard()],
        ),
        CustomRoute(
          page: TestPageRoute.page,
          path: '/test',
          transitionsBuilder: TransitionsBuilders.slideTop,
          durationInMilliseconds: 300,
          guards: [AuthGuard()],
        ),
        CustomRoute(
          page: TestFinishRoute.page,
          path: '/test_finish',
          transitionsBuilder: TransitionsBuilders.slideBottom,
          durationInMilliseconds: 300,
          guards: [AuthGuard()],
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

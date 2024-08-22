// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [ForgetPasswordScreen]
class ForgetPasswordRoute extends PageRouteInfo<void> {
  const ForgetPasswordRoute({List<PageRouteInfo>? children})
      : super(
          ForgetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgetPasswordScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterScreen();
    },
  );
}

/// generated route for
/// [TestFinishScreen]
class TestFinishRoute extends PageRouteInfo<TestFinishRouteArgs> {
  TestFinishRoute({
    Key? key,
    required TestModel test,
    List<PageRouteInfo>? children,
  }) : super(
          TestFinishRoute.name,
          args: TestFinishRouteArgs(
            key: key,
            test: test,
          ),
          initialChildren: children,
        );

  static const String name = 'TestFinishRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TestFinishRouteArgs>();
      return TestFinishScreen(
        key: args.key,
        test: args.test,
      );
    },
  );
}

class TestFinishRouteArgs {
  const TestFinishRouteArgs({
    this.key,
    required this.test,
  });

  final Key? key;

  final TestModel test;

  @override
  String toString() {
    return 'TestFinishRouteArgs{key: $key, test: $test}';
  }
}

/// generated route for
/// [TestPageScreen]
class TestPageRoute extends PageRouteInfo<void> {
  const TestPageRoute({List<PageRouteInfo>? children})
      : super(
          TestPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'TestPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TestPageScreen();
    },
  );
}

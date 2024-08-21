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
/// [NewHomeScreen]
class NewHomeRoute extends PageRouteInfo<void> {
  const NewHomeRoute({List<PageRouteInfo>? children})
      : super(
          NewHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewHomeScreen();
    },
  );
}

/// generated route for
/// [NewTestFinishScreen]
class NewTestFinishRoute extends PageRouteInfo<NewTestFinishRouteArgs> {
  NewTestFinishRoute({
    Key? key,
    required TestModel test,
    List<PageRouteInfo>? children,
  }) : super(
          NewTestFinishRoute.name,
          args: NewTestFinishRouteArgs(
            key: key,
            test: test,
          ),
          initialChildren: children,
        );

  static const String name = 'NewTestFinishRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewTestFinishRouteArgs>();
      return NewTestFinishScreen(
        key: args.key,
        test: args.test,
      );
    },
  );
}

class NewTestFinishRouteArgs {
  const NewTestFinishRouteArgs({
    this.key,
    required this.test,
  });

  final Key? key;

  final TestModel test;

  @override
  String toString() {
    return 'NewTestFinishRouteArgs{key: $key, test: $test}';
  }
}

/// generated route for
/// [NewTestScreen]
class NewTestRoute extends PageRouteInfo<NewTestRouteArgs> {
  NewTestRoute({
    Key? key,
    required TestModel testModel,
    List<PageRouteInfo>? children,
  }) : super(
          NewTestRoute.name,
          args: NewTestRouteArgs(
            key: key,
            testModel: testModel,
          ),
          initialChildren: children,
        );

  static const String name = 'NewTestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewTestRouteArgs>();
      return NewTestScreen(
        key: args.key,
        testModel: args.testModel,
      );
    },
  );
}

class NewTestRouteArgs {
  const NewTestRouteArgs({
    this.key,
    required this.testModel,
  });

  final Key? key;

  final TestModel testModel;

  @override
  String toString() {
    return 'NewTestRouteArgs{key: $key, testModel: $testModel}';
  }
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

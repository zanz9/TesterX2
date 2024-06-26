// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HistoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoryScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    TestFinishRoute.name: (routeData) {
      final args = routeData.argsAs<TestFinishRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TestFinishScreen(
          key: args.key,
          testName: args.testName,
          testId: args.testId,
          questions: args.questions,
          progressMap: args.progressMap,
          correct: args.correct,
          wrong: args.wrong,
          length: args.length,
          path: args.path,
        ),
      );
    },
    TestPageRoute.name: (routeData) {
      final args = routeData.argsAs<TestPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TestPageScreen(
          key: args.key,
          questions: args.questions,
          testName: args.testName,
          testId: args.testId,
        ),
      );
    },
    TestPreviewRoute.name: (routeData) {
      final args = routeData.argsAs<TestPreviewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TestPreviewScreen(
          key: args.key,
          testName: args.testName,
          file: args.file,
          testId: args.testId,
        ),
      );
    },
  };
}

/// generated route for
/// [HistoryScreen]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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

  static const PageInfo<void> page = PageInfo<void>(name);
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

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TestFinishScreen]
class TestFinishRoute extends PageRouteInfo<TestFinishRouteArgs> {
  TestFinishRoute({
    Key? key,
    required String testName,
    String? testId,
    List<Question>? questions,
    Map<int, Progress>? progressMap,
    int? correct,
    int? wrong,
    int? length,
    String? path,
    List<PageRouteInfo>? children,
  }) : super(
          TestFinishRoute.name,
          args: TestFinishRouteArgs(
            key: key,
            testName: testName,
            testId: testId,
            questions: questions,
            progressMap: progressMap,
            correct: correct,
            wrong: wrong,
            length: length,
            path: path,
          ),
          initialChildren: children,
        );

  static const String name = 'TestFinishRoute';

  static const PageInfo<TestFinishRouteArgs> page =
      PageInfo<TestFinishRouteArgs>(name);
}

class TestFinishRouteArgs {
  const TestFinishRouteArgs({
    this.key,
    required this.testName,
    this.testId,
    this.questions,
    this.progressMap,
    this.correct,
    this.wrong,
    this.length,
    this.path,
  });

  final Key? key;

  final String testName;

  final String? testId;

  final List<Question>? questions;

  final Map<int, Progress>? progressMap;

  final int? correct;

  final int? wrong;

  final int? length;

  final String? path;

  @override
  String toString() {
    return 'TestFinishRouteArgs{key: $key, testName: $testName, testId: $testId, questions: $questions, progressMap: $progressMap, correct: $correct, wrong: $wrong, length: $length, path: $path}';
  }
}

/// generated route for
/// [TestPageScreen]
class TestPageRoute extends PageRouteInfo<TestPageRouteArgs> {
  TestPageRoute({
    Key? key,
    required List<Question> questions,
    required String testName,
    required String? testId,
    List<PageRouteInfo>? children,
  }) : super(
          TestPageRoute.name,
          args: TestPageRouteArgs(
            key: key,
            questions: questions,
            testName: testName,
            testId: testId,
          ),
          initialChildren: children,
        );

  static const String name = 'TestPageRoute';

  static const PageInfo<TestPageRouteArgs> page =
      PageInfo<TestPageRouteArgs>(name);
}

class TestPageRouteArgs {
  const TestPageRouteArgs({
    this.key,
    required this.questions,
    required this.testName,
    required this.testId,
  });

  final Key? key;

  final List<Question> questions;

  final String testName;

  final String? testId;

  @override
  String toString() {
    return 'TestPageRouteArgs{key: $key, questions: $questions, testName: $testName, testId: $testId}';
  }
}

/// generated route for
/// [TestPreviewScreen]
class TestPreviewRoute extends PageRouteInfo<TestPreviewRouteArgs> {
  TestPreviewRoute({
    Key? key,
    required String testName,
    File? file,
    String? testId,
    List<PageRouteInfo>? children,
  }) : super(
          TestPreviewRoute.name,
          args: TestPreviewRouteArgs(
            key: key,
            testName: testName,
            file: file,
            testId: testId,
          ),
          initialChildren: children,
        );

  static const String name = 'TestPreviewRoute';

  static const PageInfo<TestPreviewRouteArgs> page =
      PageInfo<TestPreviewRouteArgs>(name);
}

class TestPreviewRouteArgs {
  const TestPreviewRouteArgs({
    this.key,
    required this.testName,
    this.file,
    this.testId,
  });

  final Key? key;

  final String testName;

  final File? file;

  final String? testId;

  @override
  String toString() {
    return 'TestPreviewRouteArgs{key: $key, testName: $testName, file: $file, testId: $testId}';
  }
}

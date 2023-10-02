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
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    TestEditorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TestEditorScreen(),
      );
    },
    TestFinishRoute.name: (routeData) {
      final args = routeData.argsAs<TestFinishRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TestFinishScreen(
          key: args.key,
          questions: args.questions,
          progressMap: args.progressMap,
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
/// [TestEditorScreen]
class TestEditorRoute extends PageRouteInfo<void> {
  const TestEditorRoute({List<PageRouteInfo>? children})
      : super(
          TestEditorRoute.name,
          initialChildren: children,
        );

  static const String name = 'TestEditorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TestFinishScreen]
class TestFinishRoute extends PageRouteInfo<TestFinishRouteArgs> {
  TestFinishRoute({
    Key? key,
    required List<Question> questions,
    required Map<int, Progress> progressMap,
    List<PageRouteInfo>? children,
  }) : super(
          TestFinishRoute.name,
          args: TestFinishRouteArgs(
            key: key,
            questions: questions,
            progressMap: progressMap,
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
    required this.questions,
    required this.progressMap,
  });

  final Key? key;

  final List<Question> questions;

  final Map<int, Progress> progressMap;

  @override
  String toString() {
    return 'TestFinishRouteArgs{key: $key, questions: $questions, progressMap: $progressMap}';
  }
}

/// generated route for
/// [TestPageScreen]
class TestPageRoute extends PageRouteInfo<TestPageRouteArgs> {
  TestPageRoute({
    Key? key,
    required List<Question> questions,
    List<PageRouteInfo>? children,
  }) : super(
          TestPageRoute.name,
          args: TestPageRouteArgs(
            key: key,
            questions: questions,
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
  });

  final Key? key;

  final List<Question> questions;

  @override
  String toString() {
    return 'TestPageRouteArgs{key: $key, questions: $questions}';
  }
}

/// generated route for
/// [TestPreviewScreen]
class TestPreviewRoute extends PageRouteInfo<TestPreviewRouteArgs> {
  TestPreviewRoute({
    Key? key,
    required String testName,
    required File file,
    List<PageRouteInfo>? children,
  }) : super(
          TestPreviewRoute.name,
          args: TestPreviewRouteArgs(
            key: key,
            testName: testName,
            file: file,
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
    required this.file,
  });

  final Key? key;

  final String testName;

  final File file;

  @override
  String toString() {
    return 'TestPreviewRouteArgs{key: $key, testName: $testName, file: $file}';
  }
}

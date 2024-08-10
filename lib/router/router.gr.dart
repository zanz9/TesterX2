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
/// [HistoryScreen]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HistoryScreen();
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
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
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
/// [NewTestScreen]
class NewTestRoute extends PageRouteInfo<void> {
  const NewTestRoute({List<PageRouteInfo>? children})
      : super(
          NewTestRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewTestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewTestScreen();
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
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TestFinishRouteArgs>();
      return TestFinishScreen(
        key: args.key,
        testName: args.testName,
        testId: args.testId,
        questions: args.questions,
        progressMap: args.progressMap,
        correct: args.correct,
        wrong: args.wrong,
        length: args.length,
        path: args.path,
      );
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TestPageRouteArgs>();
      return TestPageScreen(
        key: args.key,
        questions: args.questions,
        testName: args.testName,
        testId: args.testId,
      );
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TestPreviewRouteArgs>();
      return TestPreviewScreen(
        key: args.key,
        testName: args.testName,
        file: args.file,
        testId: args.testId,
      );
    },
  );
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/core/router/router.dart';
import 'package:testerx2/repository/repository.dart';

part 'test_edit_event.dart';
part 'test_edit_state.dart';

class TestEditBloc extends Bloc<TestEditEvent, TestEditState> {
  int testIndex = 0;
  TextEditingController testTitleController = TextEditingController();
  TextEditingController questionTitleController = TextEditingController();
  List<TextEditingController> answerControllers = [];

  late TestModel testModel;

  TestEditBloc() : super(TestEditInitial()) {
    on<OnTestEditAnswerAdd>((event, emit) async {
      answerControllers.add(TextEditingController());
      testModel.tests[testIndex].body.add(TestFileBody(
        text: answerControllers[answerControllers.length - 1].text,
        score: 0,
      ));
      emit(TestEditLoaded());
    });

    on<OnTestEditAnswerDelete>((event, emit) async {
      answerControllers.removeAt(event.index);
      List<TestFileBody> body = testModel.tests[testIndex].body;
      if (body[event.index].score > 0) {
        testModel.tests[testIndex].maxScore -= body[event.index].score;
      }
      body.removeAt(event.index);
      emit(TestEditLoaded());
    });

    on<OnTestEditSave>((event, emit) async {
      await saveValuesFromInputs();
      emit(TestEditLoaded());
    });

    on<OnTestEdit>((event, emit) async {
      var editTestLocal = GetIt.I<SharedPreferences>().getString('editTest');
      if (editTestLocal == null) {
        answerControllers.addAll([
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
        ]);
        TestFileModel testFileModel = TestFileModel(
          title: testTitleController.text,
          maxScore: 0,
          body: [
            TestFileBody(text: answerControllers[0].text, score: 0),
            TestFileBody(text: answerControllers[1].text, score: 0),
            TestFileBody(text: answerControllers[2].text, score: 0),
            TestFileBody(text: answerControllers[3].text, score: 0),
            TestFileBody(text: answerControllers[4].text, score: 0),
          ],
        );
        AuthModel? user = await GetIt.I<AuthRepository>().getUser();
        if (user == null || user.groupId == null) {
          return await GetIt.I<AppRouter>().replaceAll([const HomeRoute()]);
        }
        testModel = TestModel(
          name: testTitleController.text,
          path: '',
          groupId: user.groupId!, // TODO: user group to test group if edit test
          createdAt: DateTime.now(),
          authorId: GetIt.I<AuthRepository>().getMyUid()!,
        );
        testModel.id = '';
        testModel.tests = [testFileModel];
        testModel.author = user;
        testModel.group = GroupModel(
            id: user.groupId!,
            name: (await GetIt.I<GroupRepository>().getMyGroup())!);
        await GetIt.I<SharedPreferences>().setString(
          'editTest',
          jsonEncode(testModel.toJsonAllFields()),
        );
        emit(TestEditLoaded());
      } else {
        testModel = TestModel.fromJsonAllFields(jsonDecode(editTestLocal));

        testTitleController.text = testModel.name;
        questionTitleController.text = testModel.tests[testIndex].title;
        for (int i = 0; i < testModel.tests[testIndex].body.length; i++) {
          answerControllers.add(TextEditingController(
              text: testModel.tests[testIndex].body[i].text));
        }

        emit(TestEditLoaded());
      }
    });

    on<OnTestEditQuestionNext>((event, emit) async {
      await saveValuesFromInputs();
      testIndex++;
      if (testModel.tests.length <= testIndex) {
        testModel.tests.add(TestFileModel(
          title: '',
          maxScore: 0,
          body: [
            for (int i = 0; i < testModel.tests[testIndex - 1].body.length; i++)
              TestFileBody(text: '', score: 0),
          ],
        ));
        await GetIt.I<SharedPreferences>()
            .setString('editTest', jsonEncode(testModel.toJsonAllFields()));
      }
      TestFileModel test = testModel.tests[testIndex];
      questionTitleController = TextEditingController(text: test.title);
      answerControllers.clear();
      for (int i = 0; i < test.body.length; i++) {
        answerControllers.add(TextEditingController(text: test.body[i].text));
      }

      emit(TestEditLoaded());
    });

    on<OnTestEditQuestionPrev>((event, emit) async {
      if (testIndex < 1) return;
      await saveValuesFromInputs();
      testIndex--;
      TestFileModel test = testModel.tests[testIndex];
      questionTitleController = TextEditingController(text: test.title);
      answerControllers.clear();
      for (int i = 0; i < test.body.length; i++) {
        answerControllers.add(TextEditingController(text: test.body[i].text));
      }
      emit(TestEditLoaded());
    });
  }

  Future<void> saveValuesFromInputs() async {
    TestFileModel testFileModel = testModel.tests[testIndex];
    testModel.name = testTitleController.text;
    testFileModel.title = questionTitleController.text;
    int counter = 0;
    for (TestFileBody el in testFileModel.body) {
      el.text = answerControllers[counter++].text;
    }
    await GetIt.I<SharedPreferences>()
        .setString('editTest', jsonEncode(testModel.toJsonAllFields()));
  }
}

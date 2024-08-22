import 'package:testerx2/repository/repository.dart';

class TestModel {
  late String id;
  final String name;
  final String path;
  final String groupId;
  late GroupModel group;
  late List<TestFileModel> tests;

  TestModel({
    required this.name,
    required this.path,
    required this.groupId,
  });

  factory TestModel.fromJson(Map json, String id) {
    var testModel = TestModel(
      name: json['name'] as String,
      path: json['path'] as String,
      groupId: json['groupId'] as String,
    );
    testModel.id = id;
    return testModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['path'] = path;
    data['groupId'] = groupId;
    return data;
  }

  factory TestModel.fromJsonAllFields(Map json) {
    var testModel = TestModel(
      name: json['name'] as String,
      path: json['path'] as String,
      groupId: json['groupId'] as String,
    );
    testModel.id = json['id'] as String;
    testModel.group = GroupModel.fromJson(json['group'] as Map);
    testModel.tests = (json['tests'] as List)
        .map((v) => TestFileModel.fromJsonHistory(v as Map))
        .toList();
    return testModel;
  }

  Map<String, dynamic> toJsonAllFields() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['path'] = path;
    data['groupId'] = groupId;
    data['group'] = group.toJson();
    data['tests'] = tests.map((v) => v.toJsonHistory()).toList();
    return data;
  }
}

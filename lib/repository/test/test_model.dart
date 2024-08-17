import 'package:testerx2/repository/repository.dart';

class TestModel {
  final String name;
  final String path;
  final String groupId;
  late GroupModel group;

  TestModel({
    required this.name,
    required this.path,
    required this.groupId,
  });

  factory TestModel.fromJson(Map json) {
    return TestModel(
      name: json['name'] as String,
      path: json['path'] as String,
      groupId: json['groupId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['path'] = path;
    data['groupId'] = groupId;
    return data;
  }
}

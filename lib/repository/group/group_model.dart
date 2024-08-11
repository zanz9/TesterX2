class GroupModel {
  GroupModel({required this.id, required this.name});

  String id;
  String name;

  factory GroupModel.fromJson(Map json) {
    return GroupModel(
      name: json['name'] as String,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

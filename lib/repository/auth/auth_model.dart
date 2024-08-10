class AuthModel {
  AuthModel({required this.groupId});

  String groupId;

  factory AuthModel.fromJson(Map json) {
    return AuthModel(
      groupId: json['groupId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupId'] = groupId;
    return data;
  }
}

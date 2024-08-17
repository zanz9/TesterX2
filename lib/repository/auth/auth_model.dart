class AuthModel {
  AuthModel({this.groupId, this.isAdmin = false});

  String? groupId;
  bool isAdmin;

  factory AuthModel.fromJson(Map json) {
    return AuthModel(
      groupId: json['groupId'] as String?,
      isAdmin: json['isAdmin'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupId'] = groupId;
    data['isAdmin'] = isAdmin;
    return data;
  }
}

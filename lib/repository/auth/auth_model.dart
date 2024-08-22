class AuthModel {
  AuthModel({this.groupId, this.isAdmin = false, this.displayName});
  String? displayName;
  String? groupId;
  bool isAdmin;

  factory AuthModel.fromJson(Map json, String? displayName) {
    return AuthModel(
      displayName: displayName,
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

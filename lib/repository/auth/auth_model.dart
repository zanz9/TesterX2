class AuthModel {
  AuthModel({
    this.groupId,
    this.isAdmin = false,
    this.displayName = 'Пользователь',
    this.token,
  });
  String displayName;
  String? groupId;
  bool isAdmin;
  String? token;
  String? uid;

  factory AuthModel.fromJson(Map json) {
    return AuthModel(
      displayName: json['displayName'] ?? 'Пользователь',
      groupId: json['groupId'] as String?,
      isAdmin: json['isAdmin'] ?? false,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['groupId'] = groupId;
    data['isAdmin'] = isAdmin;
    data['token'] = token;
    return data;
  }
}

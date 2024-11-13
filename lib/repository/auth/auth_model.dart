class AuthModel {
  AuthModel({
    this.groupId,
    this.isAdmin = false,
    this.displayName = 'Пользователь',
  });
  String displayName;
  String? groupId;
  bool isAdmin;

  factory AuthModel.fromJson(Map json) {
    return AuthModel(
      displayName: json['displayName'] ?? 'Пользователь',
      groupId: json['groupId'] as String?,
      isAdmin: json['isAdmin'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['groupId'] = groupId;
    data['isAdmin'] = isAdmin;
    return data;
  }
}

class Question {
  List<String>? title;
  List<String>? rights;
  List<String>? answers;

  Question({
    required this.title,
    required this.rights,
    required this.answers,
  });

  Question.fromJson(Map<String, dynamic> json) {
    title = json['title'].cast<String>();
    rights = json['rights'].cast<String>();
    answers = json['answers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['rights'] = rights;
    data['answers'] = answers;
    return data;
  }
}

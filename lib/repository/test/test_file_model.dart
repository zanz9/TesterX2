class TestFileModel {
  final String title;
  final int maxScore;
  final List<TestFileBody> body;
  // runtime
  List<int> answers = [];
  bool answered = false;
  int receive = 0;

  TestFileModel({
    required this.title,
    required this.maxScore,
    required this.body,
    List<int>? answers,
    this.answered = false,
    this.receive = 0,
  }) : answers = answers ?? [];

  factory TestFileModel.fromJson(Map json) {
    return TestFileModel(
      title: json['title'] as String,
      maxScore: json['maxScore'] as int,
      body: (json['body'] as List).map((el) {
        return TestFileBody.fromJson(el);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['maxScore'] = maxScore;
    data['body'] = body.map((v) => v.toJson()).toList();
    return data;
  }

  clear() {
    answers = [];
    answered = false;
    receive = 0;
  }

  factory TestFileModel.fromJsonHistory(Map json) {
    return TestFileModel(
      title: json['title'] as String,
      maxScore: json['maxScore'] as int,
      body: (json['body'] as List).map((el) {
        return TestFileBody.fromJson(el);
      }).toList(),
      answers: json['answers'].cast<int>() as List<int>,
      answered: json['answered'] as bool,
      receive: json['receive'] as int,
    );
  }

  Map<String, dynamic> toJsonHistory() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['maxScore'] = maxScore;
    data['body'] = body.map((v) => v.toJson()).toList();
    data['answers'] = answers;
    data['answered'] = answered;
    data['receive'] = receive;
    return data;
  }
}

class TestFileBody {
  final String text;
  final int score;

  TestFileBody({required this.text, required this.score});

  factory TestFileBody.fromJson(Map json) {
    return TestFileBody(
      text: json['text'] as String,
      score: json['score'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['score'] = score;
    return data;
  }
}

class TestFileModel {
  final String title;
  final double maxScore;
  final List<TestFileBody> body;

  TestFileModel(
      {required this.title, required this.maxScore, required this.body});

  factory TestFileModel.fromJson(Map json) {
    return TestFileModel(
      title: json['title'] as String,
      maxScore: json['maxScore'] as double,
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
}

class TestFileBody {
  final String text;
  final double score;

  TestFileBody({required this.text, required this.score});

  factory TestFileBody.fromJson(Map json) {
    return TestFileBody(
      text: json['text'] as String,
      score: json['score'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['score'] = score;
    return data;
  }
}

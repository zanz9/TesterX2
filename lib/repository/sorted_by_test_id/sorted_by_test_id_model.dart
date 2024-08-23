class SortedByTestIdModel {
  final String userId;
  final String testId;
  final String historyId;
  final int correct;
  final int maxScore;
  final DateTime timestamp;

  SortedByTestIdModel({
    required this.userId,
    required this.testId,
    required this.historyId,
    required this.correct,
    required this.maxScore,
    required this.timestamp,
  });

  factory SortedByTestIdModel.fromJson(Map json) {
    return SortedByTestIdModel(
      userId: json['userId'] as String,
      testId: json['testId'] as String,
      historyId: json['historyId'] as String,
      correct: (json['correct'] as num).toInt(),
      maxScore: (json['maxScore'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['testId'] = testId;
    data['historyId'] = historyId;
    data['correct'] = correct;
    data['maxScore'] = maxScore;
    data['timestamp'] = timestamp.toIso8601String();
    return data;
  }
}

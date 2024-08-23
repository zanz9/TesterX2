import 'package:testerx2/repository/repository.dart';

class HistoryModel {
  final String testId;
  final DateTime timestamp;
  final String userId;
  final int correct;
  final int maxScore;
  final int testLength;
  final String pathHistory;
  late TestModel test;

  HistoryModel({
    required this.testId,
    required this.timestamp,
    required this.userId,
    required this.correct,
    required this.maxScore,
    required this.testLength,
    required this.pathHistory,
  });

  factory HistoryModel.fromJson(Map json) {
    return HistoryModel(
      testId: json['testId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['userId'] as String,
      correct: (json['correct'] as num).toInt(),
      maxScore: (json['maxScore'] as num).toInt(),
      testLength: (json['testLength'] as num).toInt(),
      pathHistory: json['pathHistory'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['testId'] = testId;
    data['timestamp'] = timestamp.toIso8601String();
    data['userId'] = userId;
    data['correct'] = correct;
    data['maxScore'] = maxScore;
    data['testLength'] = testLength;
    data['pathHistory'] = pathHistory;
    return data;
  }
}

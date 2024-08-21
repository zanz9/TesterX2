import 'package:testerx2/repository/repository.dart';

class HistoryModel {
  final String testId;
  final DateTime timestamp;
  final String userId;
  final int correct;
  final int testLength;
  final String pathHistory;
  late TestModel test;

  HistoryModel({
    required this.testId,
    required this.timestamp,
    required this.userId,
    required this.correct,
    required this.testLength,
    required this.pathHistory,
  });

  factory HistoryModel.fromJson(Map json) {
    return HistoryModel(
      testId: json['testId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['userId'] as String,
      correct: json['correct'] as int,
      testLength: json['testLength'] as int,
      pathHistory: json['pathHistory'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['testId'] = testId;
    data['timestamp'] = timestamp.toIso8601String();
    data['userId'] = userId;
    data['correct'] = correct;
    data['testLength'] = testLength;
    data['pathHistory'] = pathHistory;
    return data;
  }
}

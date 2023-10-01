import 'package:testerx2/models/question.dart';

class TX {
  bool? multiple;
  List<Question>? questions;

  TX({
    required this.multiple,
    required this.questions,
  });

  TX.fromJson(Map<String, dynamic> json) {
    multiple = json['multiple'];
    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions!.add(Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['multiple'] = multiple;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

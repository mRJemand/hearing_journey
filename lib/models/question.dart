import 'dart:convert';

class Question {
  final int number;
  final String question;
  final String phase;
  final String answer_1;
  final String answer_2;
  final String? answer_3;
  final String? answer_4;
  final String? answer_5;

  const Question({
    required this.number,
    required this.question,
    required this.phase,
    required this.answer_1,
    required this.answer_2,
    this.answer_3,
    this.answer_4,
    this.answer_5,
  });

  Question.fromJson(Map<String, dynamic> json)
      : number = json['number'] as int,
        question = json['question'] as String,
        phase = json['phase'] as String,
        answer_1 = json['answer_1'] as String,
        answer_2 = json['answer_2'] as String,
        answer_3 = json['answer_3'] as String,
        answer_4 = json['answer_4'] as String,
        answer_5 = json['answer_5'] as String;

  Map<String, dynamic> toJson() => {
        'number': number,
        'question': question,
        'phase': phase,
        'answer_1': answer_1,
        'answer_2': answer_2,
        'answer_3': answer_3,
        'answer_4': answer_4,
        'answer_5': answer_5,
      };
}

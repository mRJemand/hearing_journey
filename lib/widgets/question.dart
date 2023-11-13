import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  final questionObject;

  const QuestionWidget({
    required this.questionObject,
    super.key,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  void selectAnswer() {}

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frage ${widget.questionObject['number'].toString()}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 16),
            Text(
              widget.questionObject['question'],
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectAnswer,
                    child: Text(widget.questionObject['answer_1']),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectAnswer,
                    child: Text(widget.questionObject['answer_2']),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectAnswer,
                    child: Text(widget.questionObject['answer_3']),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectAnswer,
                    child: Text(widget.questionObject['answer_4']),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectAnswer,
                    child: Text(widget.questionObject['answer_5']),
                  ),
                ),
                // Container(
                //   width: double.infinity,
                //   child: AnswerButton(
                //     answer: 1,
                //     isSelected:
                //         selectedAnswers[questions[currentQuestionIndex]] == 1,
                //     onSelect: selectAnswer,
                //   ),
                // ),
                // Container(
                //   width: double.infinity,
                //   child: AnswerButton(
                //     answer: 2,
                //     isSelected:
                //         selectedAnswers[questions[currentQuestionIndex]] == 2,
                //     onSelect: selectAnswer,
                //   ),
                // ),
                // Container(
                //   width: double.infinity,
                //   child: AnswerButton(
                //     answer: 3,
                //     isSelected:
                //         selectedAnswers[questions[currentQuestionIndex]] == 3,
                //     onSelect: selectAnswer,
                //   ),
                // ),
                // Container(
                //   width: double.infinity,
                //   child: AnswerButton(
                //     answer: 4,
                //     isSelected:
                //         selectedAnswers[questions[currentQuestionIndex]] == 4,
                //     onSelect: selectAnswer,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TriviaQuestions {
  //int responseCode;
  late List<TriviaQuestion> questions;

  TriviaQuestions({/*this.responseCode,*/required this.questions});

  TriviaQuestions.fromJson(Map<String, dynamic> json) {
    //responseCode = json['response_code'];
    if (json['results'] != null) {
      questions = <TriviaQuestion>[];
      
      json['results'].forEach((v) {
        questions.add(TriviaQuestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['response_code'] = this.responseCode;
    if (questions.isNotEmpty) {
      data['results'] = questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class TriviaQuestion {
  TriviaQuestion({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers
  });

  late String category;
  late String type;
  late String difficulty;
  late String question;
  late String correctAnswer;
  late List<String> incorrectAnswers;

  TriviaQuestion.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    type = json['type'];
    difficulty = json['difficulty'];
    question = json['question'];
    correctAnswer = json['correct_answer'];
    incorrectAnswers = json['incorrect_answers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['type'] = type;
    data['difficulty'] = difficulty;
    data['question'] = question;
    data['correct_answer'] = correctAnswer;
    data['incorrect_answers'] = incorrectAnswers;
    return data;
  }

  @override
  String toString() {
    return 'Question: $question, Answer: $correctAnswer\n';
  }
}
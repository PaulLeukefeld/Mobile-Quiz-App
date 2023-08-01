class QuizQuestion {
  QuizQuestion(
      {this.question,
      this.correctAnswer,
      this.incorrectAnswer1,
      this.incorrectAnswer2,
      this.incorrectAnswer3,
      this.negativeScore,
      this.questionUid,
      this.correctlyAnswered,
      this.falselyAnswered,
      this.amountAnswered,
      this.difficulty});
  final String question;
  final String correctAnswer;
  final String incorrectAnswer1;
  final String incorrectAnswer2;
  final String incorrectAnswer3;
  String negativeScore;
  final String questionUid;
  String correctlyAnswered;
  String falselyAnswered;
  String amountAnswered;
  String difficulty;
}

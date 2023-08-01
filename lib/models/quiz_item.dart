///Quiz item model that holds all information associated with a quiz card
class QuizItem {
  final String name;
  final String color;
  final int numberOfQuestions;
  final String difficulty;
  final String image;
  QuizItem(
      {this.name,
      this.color,
      this.numberOfQuestions,
      this.difficulty,
      this.image});
}

class Arithmetic {
  ArrayList<String> questions = new ArrayList<String>();
  Arithmetic() {
    setupQuestions();
  }
  
  void drawMe() {
    background(255);
    fill(0);
    textSize(72);
    text(randomQuestion(), width/3, height/2);
  }
  
  int checkInput() {
    return -1;
  }
  
  void correctAnswer() {
  }
  
  void incorrectAnswer() {
  }
  
  String randomQuestion() {
    return questions.get(int(random(questions.size())));
  }
  
  void setupQuestions() {
    questions.add("4 + 7 = ");
  }
}

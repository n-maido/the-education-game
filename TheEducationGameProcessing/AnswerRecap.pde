class AnswerRecap {
  ArrayList<Boolean> qs = new ArrayList<Boolean>();
  AnswerRecap() {
    qs.addAll(questions);
    questions.clear();
  }
  
  void resetQuestions() {
    qs.clear();
    qs.addAll(questions);
    questions.clear();
    for (int i = 0; i < questions.size(); i++) {
      println("questions" + str(questions.get(i)));
    }
  }
  void drawMe() {
    if (correctAnswers() / qs.size() > 0.5) {
      background(0, 255, 0);
    } else {
      background(255, 0, 0);
    }
    fill(0);
    textSize(72);
    
    text("You got ", width/10, height/2);
    text(str(correctAnswers()) + " out of " + str(qs.size()), width/2, height/2);
  }
  
  int correctAnswers() {
    int tempRight = 0;
    for (int i = 0; i < qs.size(); i++) {
      println("qs" + str(qs.get(i)));
      if (qs.get(i) == true) {
        tempRight++;
      }
    }
    return tempRight;
  }
}

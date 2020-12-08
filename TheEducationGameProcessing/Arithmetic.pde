class Arithmetic {
  ArrayList<String> questions = new ArrayList<String>();
  ArrayList<Integer> answers = new ArrayList<Integer>();
  String answer = "";
  int questionLoc;
  String currentQuestion;
  Arithmetic() {
    setupQuestions();
    currentQuestion = selectQuestion();
    questionLoc = questions.indexOf(currentQuestion);
  }
  
  void drawMe() {
    background(255);
    fill(0);
    textSize(72);
    
    text(currentQuestion + answer, width/3, height/2);
  }
  
  int checkInput() {
    return -1;
  }
  
  String selectQuestion() {
    return randomQuestion();
  }
  
  void correctAnswer() {
  }
  
  void incorrectAnswer() {
  }
  
  void checkAnswer() {
    try {
      if (int(answer) == answers.get(questionLoc)) {
        //changeScene("corr");
        questionCompleted(true, "math");
        answer = "";
      } else {
        questionCompleted(false, "math");
        answer = "";
        //changeScene("inCorr");
      }
    } catch(Exception e) {
    }
  }
  
  String randomQuestion() {
    return questions.get(int(random(questions.size())));
  }
  
  void setupQuestions() {
    questions.add("4 + 7 = ");
    questions.add("10 + 11 = ");
    answers.add(11);
    answers.add(21);
    questions.add("18 + 12 = ");
    answers.add(30);
  }
  
  public void mathKeyPressed(char key) {
    try {
      if ((int(key)) >= 48 && (int(key) <= 57)) { 
        answer += key;
      } else if (key == ENTER) {
        checkAnswer();
      } else if (key == BACKSPACE) {
        answer = answer.substring(0, answer.length()-1);
      }
    } catch(Exception e) {
    }
  }
    
}

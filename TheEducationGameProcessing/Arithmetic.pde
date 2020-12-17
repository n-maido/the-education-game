class Arithmetic {
  /* //Steven
  ArrayList<String> questions = new ArrayList<String>();
  ArrayList<Integer> answers = new ArrayList<Integer>();
  String answer = "";
  int questionLoc;
  String currentQuestion;
  */
  
  //Nhi
  int addend1;
  int addend2;
  int sum;
  String answer = "";
  boolean keepGenerating = true;
  
  Arithmetic() {
    //setupQuestions();
    /*
    currentQuestion = selectQuestion();
    questionLoc = questions.indexOf(currentQuestion);
    */
  }
  
  void drawMe() {
    background(255);
    fill(0);
    textSize(92);
    
    if(keepGenerating == true){
      setupQuestions();
    }
    
    //Steven: text(currentQuestion + answer, width/3, height/2);
    text(addend1 + " + " + addend2 + " = " + answer, width/3, height/2);
  }
  
  /*
  void chooseNewQuestion() {
    currentQuestion = selectQuestion();
    questionLoc = questions.indexOf(currentQuestion);
  }
  */
  
  int checkInput() {
    return -1;
  }
  
  /*
  String selectQuestion() {
    return randomQuestion();
  }
  */
  
  void correctAnswer() {
  }
  
  void incorrectAnswer() {
  }
  
  void checkAnswer() {
    /* Steven
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
      chooseNewQuestion();
    } catch(Exception e) {
    }
    */
    
    //Nhi
    try{
      if(int(answer) == sum){
        questionCompleted(true, "math");
        answer = "";
        keepGenerating = true;
      }
      else {
        questionCompleted(false, "math");
        answer = "";
        keepGenerating = true;
      }
    } catch(Exception e){
    }
    
  }
  
  /*
  String randomQuestion() {
    return questions.get(int(random(questions.size())));
  }
  */
  
  void setupQuestions() {
    /*
    questions.add("4 + 7 = ");
    questions.add("10 + 11 = ");
    answers.add(11);
    answers.add(21);
    questions.add("18 + 12 = ");
    answers.add(30);
    */
    keepGenerating = false;
    addend1 = int(random(1, 20));
    addend2 = int(random(1, 20));
    sum = addend1 + addend2;
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

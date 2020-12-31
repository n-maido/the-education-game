/*
 * AnswerRecap.pde
 *
 * Description: Keeps track of correct/incorrect answers. When a section concludes, displays how many questions the user answered correctly
 *
 * Authors: Steven Kobza, Nhi Mai-Do
 *
*/

class AnswerRecap {
  //Arraylist to track all of the questions
  ArrayList<Boolean> qs = new ArrayList<Boolean>();
  
  AnswerRecap() {
    //Adding all to the qs arraylist, and then clearing the questions arraylist.
    qs.addAll(questions);
    questions.clear();
  }
  
  void resetQuestions() {
    //Clearing qs, adding all and then clearing
    qs.clear();
    qs.addAll(questions);
    questions.clear();
    for (int i = 0; i < questions.size(); i++) {
      //Printing out answers for debugging
      println("questions" + str(questions.get(i)));
    }
  }
  
  //Description: Displays the result screen, showing the users how many questions they answered correctly
  void drawMe() {
    //If a passing score is achieved, display a green screen. Otherwise display a red screen
    if (float(correctAnswers()) / float(qs.size()) > 0.5) {
      background(0, 255, 0);
    } else {
      background(255, 0, 0);
    }
    fill(0);
    //Display results
    textSize(85);
    text("You got " + str(correctAnswers()) + " out of " + str(qs.size()), width/5 - 20, height/2);//w/3
  }
  
  //Description: Counts the number of correct answers
  int correctAnswers() {
    int tempRight = 0; //keeps track of # of right answers
    for (int i = 0; i < qs.size(); i++) {
      println("qs" + str(qs.get(i)));
      if (qs.get(i) == true) {
        tempRight++;
      }
    }
    println(tempRight);
    return tempRight;
  }
}

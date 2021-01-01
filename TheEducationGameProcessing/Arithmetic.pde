/*
 * Arithmetic.pde
 *
 * Description: The arithmetic section. Displays a randomized arithmetic question, taking keyboard inputs as a response
 *
 * Authors: Nhi Mai-Do, Steven Kobza
 *
*/

class Arithmetic {
  
  //question variables
  int addend1;
  int addend2;
  int sum;
  
  String answer = ""; //Store user input as a string
  boolean keepGenerating = true; //this bool will toggle our question generator on/off
  
  Arithmetic() {
  }
  
  void drawMe() {
    background(255);
    fill(0);
    textSize(92);
    
    if(keepGenerating == true){ //This bool will always be true upon launch. Every time we enter an arithmetic section, we generate a new question
      setupQuestions();
    }
    
    //display the question
    text(addend1 + " + " + addend2 + " = " + answer, width/4, height/2);
  }
  
 
  //Description: Checks if user's answer is correct. Concludes the question by calling questionCompleted() and resetting variables
  void checkAnswer() {   
    try{
      if(int(answer) == sum){
        questionCompleted(true, "math");
        answer = "";
        keepGenerating = true; //we reset this so that it will always be true upon launch
      }
      else {
        questionCompleted(false, "math");
        answer = "";
        keepGenerating = true;
      }
    } catch(Exception e){
    }
    
  }
  
  //Description: Generates a randomized addition question
  void setupQuestions() {
    keepGenerating = false; //Once this function is called, we can stop generating questions
    addend1 = int(random(1, 20)); //Generate the first addend, as a random int between 1 and 20
    addend2 = int(random(1, 20));
    sum = addend1 + addend2;
  }
  
  //Description: Checks for keyboard input and stores it as the answer
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

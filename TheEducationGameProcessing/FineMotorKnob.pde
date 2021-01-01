/*
 * FineMotorKnob.pde
 *
 * Description: The 1st part of the fine motor section. Draws a yellow bar and a blue bar. Prompts the user to turn a knob in order to match the blue bar to the yellow one.
 *
 * Authors: Steven Kobza, Nhi Mai-Do
 *
*/

class FineMotorKnob{
  //question variables
  float yellowHeight; //height of the yellow bar
  float currentHeight; //height of the blue bar
  
  FineMotorKnob() {
    //set up knob question
    yellowHeight = random(500); //The yellow bar's height will be randomized
    
  }
  
  //Description: Draws the yellow and blue bars. Verifies user input and concludes the question by calling questionCompleted() and generating a new question
  void drawKnob() {
    try {
      println("Potentiometer: " + inputs.get("potentiometer"));
      currentHeight = map(float(inputs.get("potentiometer")), 14, 1015, 0, 500); //Map the heights of our bars to be between 0 and 500. Pot max val: 1015, min: 14
      
    } catch(Exception e) {
      currentHeight = 250;
    }
    
    //Draw text
    background(255);
    fill(0);
    textSize(37);
    text("Twist the knob until they match:", 275, 70);
    
    //Draw bar outlines
    fill(255);
    stroke(0);
    rect(275, 125, 150, 500);
    rect(707, 125, 150, 500);
    
    //Draw bar fills
    fill(255, 255, 0);
    rect(275, 625-yellowHeight, 150, yellowHeight); //550 is the height of the rectangle outline
    fill(0, 0, 255);
    rect(707, 625-currentHeight, 150, currentHeight);
    
    //Checking input. Giving the user a bit of a buffer to get it right.
    if (currentHeight >= yellowHeight-10 && currentHeight <= yellowHeight+10) {
      questionCompleted(true, "fineKnob");
      //Setting up a new question
      newQ();
    }
  }
   
  //Description: Generates a new random height for the yellow bar  
  void newQ() {
    yellowHeight = random(500);
  }
  
}

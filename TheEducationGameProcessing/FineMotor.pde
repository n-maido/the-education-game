class FineMotor{
  //variables for the knob question
  float yellowHeight;
  float currentHeight;
  
  FineMotor() {
    //set up knob question
    yellowHeight = random(500);
    
  }
  
  void drawKnob() {
    try {
      println("Potentiometer: " + inputs.get("potentiometer"));
      currentHeight = map(float(inputs.get("potentiometer")), 14, 1015, 0, 500); //Pot max: 1015, min: 14
      
    } catch(Exception e) {
      currentHeight = 250;
    }
    
    //Draw text
    background(255);
    fill(0);
    textSize(38);
    text("Twist the knob until they match", 275, 70);
    
    //Draw rectangle outlines
    fill(255);
    stroke(0);
    rect(275, 125, 150, 500);
    rect(707, 125, 150, 500);
    
    //Draw rectangle fills
    fill(255, 255, 0);
    rect(275, 625-yellowHeight, 150, yellowHeight); //550 is the height of the rectangle outline
    fill(0, 0, 255);
    rect(707, 625-currentHeight, 150, currentHeight);
    
    //Giving the user a bit of a buffer to get right.
    if (currentHeight >= yellowHeight-10 && currentHeight <= yellowHeight+10) {
      questionCompleted(true, "fineKnob");
      //Setting up a new question
      newQ();
    }
  }
    
  void newQ() {
    yellowHeight = random(500);
  }
  void checkInput() {
  }
}

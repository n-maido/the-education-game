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
    
    background(255);
    fill(255);
    stroke(0);
    rect(width/5, 50, 150, 500);
    rect(width * 3/5, 50, 150, 500);
    fill(255, 255, 0);
    rect(width/5, 550-yellowHeight, 150, yellowHeight);
    fill(0, 0, 255);
    rect(width * 3/5, 550-currentHeight, 150, currentHeight);
    fill(0);
    textSize(40);
    text("Twist the knob until they match", width/10, 35);
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

class FineMotor {
  float yellowHeight;
  float currentHeight;
  FineMotor() {
    
    yellowHeight = random(500);
  }
  
  void drawMe() {
    try {
      currentHeight = float(inputs.get("potentiometer"));
      print(currentHeight);
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
    if (currentHeight >= yellowHeight-10 && currentHeight <= yellowHeight+10) {
      changeScene("corr");
    }
  }
  
  void checkInput() {
  }
}

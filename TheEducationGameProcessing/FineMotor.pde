class FineMotor {
  //variables for the knob question
  float yellowHeight;
  float currentHeight;
  
  //variables for the light sensor question
  int targetSeconds; //the amount of seconds we will ask the user to touch the sensor for
  float lightSensorValue;
  FineMotor() {
    //set up knob question
    yellowHeight = random(500);
    
    //set up light sensor question
    targetSeconds = 5;
  }
  
  void drawKnob() {
    try {
      println("Potentiometer: " + inputs.get("potentiometer"));
      currentHeight = map(float(inputs.get("potentiometer")), 92, 1020, 0, 500);
      
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
  
  
  void drawCounter(){
    //display the prompt
    background(255);
    textSize(40);
    text("Put your finger on the sensor for " + targetSeconds + " seconds", width/10, 35);
    
    //get the light sensor reading
    lightSensorValue = float(inputs.get("photoresistor"));
    println("Photoresistor: " + lightSensorValue);
    
    //check if finger is placed on the sensor
    if(lightSensorValue < 80){
      //when finger is placed on sensor, start the counter
      background(255);
      text("1", width/10, 35);
      
    }
    
  }
  
  
  
  void checkInput() {
  }
}

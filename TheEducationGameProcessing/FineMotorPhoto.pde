class FineMotorPhoto{
  //variables for the light sensor question
  int targetSeconds; //the amount of seconds we will ask the user to touch the sensor for
  float lightSensorValue;
  
  int timeElapsedProgram;
  int timeElapsedFinger;
  int timeStarted;
  
  boolean countingStarted = false;
  
  FineMotorPhoto(){
    //set up light sensor question
    targetSeconds = int(random(2, 6));
    //targetSeconds = 5;
  }
  
  void drawCounter(){
    //display the prompt
    background(255);
    textAlign(CENTER);
    textSize(35);
    text("Put your finger on the sensor for " + targetSeconds + " seconds", width/2, height/2);  
   
    //get the light sensor reading
    lightSensorValue = float(inputs.get("photoresistor"));
    println("Photoresistor: " + lightSensorValue);
    
    //timeElapsedFinger = 0;
    
    //check if finger is placed on the sensor
    if(lightSensorValue < 80){
      if (countingStarted == false) {
        startCounting();
      }
      //when finger is placed on sensor, start the counter
      //textAlign(CENTER);
      
      timeElapsedFinger = millis()/1000 - timeStarted;      
      println(timeElapsedProgram);
      
      //timeElapsedFinger = timeElapsedProgram -1;
      println(timeElapsedFinger);
      background(255);
      textSize(150);
      text(timeElapsedFinger, width/2, height/2);
      if (timeElapsedFinger > targetSeconds) {
        questionCompleted(true, "finePhoto");
        countingStarted = false;
        timeStarted = 0;
        timeElapsedProgram = 0;
        timeElapsedFinger = 0;
      }
    } else {
      countingStarted = false;
    }
    
    //reset to original screen settings
    textAlign(LEFT);    
  }
  
  void startCounting() {
    countingStarted = true;
    timeStarted = millis()/1000;
  }
}

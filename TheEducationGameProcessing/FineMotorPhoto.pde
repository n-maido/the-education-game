class FineMotorPhoto{
  //variables for the light sensor question
  int targetSeconds; //the amount of seconds we will ask the user to touch the sensor for
  float lightSensorValue;
  
  int timeElapsedProgram;
  int timeElapsedFinger;
  
  FineMotorPhoto(){
    //set up light sensor question
    targetSeconds = 5;
  }
  
  void drawCounter(){
    //display the prompt
    background(255);
    text("Put your finger on the sensor for " + targetSeconds + " seconds", width/10, 35);  
   
    //get the light sensor reading
    lightSensorValue = float(inputs.get("photoresistor"));
    println("Photoresistor: " + lightSensorValue);
    
    timeElapsedFinger = 0;
    
    //check if finger is placed on the sensor
    if(lightSensorValue < 80){
      //when finger is placed on sensor, start the counter
      background(255);
      textAlign(CENTER);
      //text("1", width/10, 35); 
      
      int timeElapsedProgram = millis()/1000;      
      println(timeElapsedProgram);
      
      timeElapsedFinger = timeElapsedProgram - 1;
      println(timeElapsedFinger);
      text(timeElapsedFinger, width/10, 35);
    }
    
  }
}

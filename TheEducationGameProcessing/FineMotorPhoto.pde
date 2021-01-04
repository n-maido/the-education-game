/*
 * FineMotorPhoto.pde
 *
 * Description: The 2nd part of the fine motor section. Prompts the user to place their finger on a photoresistor, for a specified amount of time
 *
 * Authors: Nhi Mai-Do, Steven Kobza
 *
*/

class FineMotorPhoto{
  //question variables
  int targetSeconds; //the amount of seconds we will ask the user to touch the sensor for
  float lightSensorValue; //the light sensor reading
  
  //timer variables
  int timeElapsedProgram; //time elapsed since the start of the program
  int timeElapsedFinger; //time elapsed since a finger was placed on the sensor
  int timeStarted; //time at which our counter starts  
  boolean countingStarted = false; //this bool will toggle our timer on/off
  
  boolean keepGenerating = true; //this bool will toggle our question generator on/off
  
  FineMotorPhoto(){
    //set up light sensor question
    targetSeconds = int(random(2, 6));
  }
  
  //Description: Displays a question prompt and counter. Verifies user input and concludes the question by calling questionCompleted() and resetting variables
  void drawCounter(){
    
    if(keepGenerating ==true){ //This bool will always be true upon launch. Every time we enter an emotion section, we generate a new question
      targetSeconds = newQuestion();
    }
  
    //display the prompt
    background(255);
    textAlign(CENTER);
    textSize(45);
    text("Put your finger on the sensor for " + targetSeconds + " seconds", width/2, height/2);  
   
    //get the light sensor reading
    lightSensorValue = float(inputs.get("photoresistor"));
    println("Photoresistor: " + lightSensorValue);
    
    //check if finger is placed on the sensor
    if(lightSensorValue < 30){//change depending on environ
      if (countingStarted == false) {
        startCounting();
      }
      //when finger is placed on sensor, start the counter      
      timeElapsedFinger = millis()/1000 - timeStarted;      
      println(timeElapsedProgram);
      println(timeElapsedFinger);
      
      //display a counter for each second that the sensor is covered
      background(255);
      textSize(200);
      text(timeElapsedFinger, width/2, height/2 + 25);
      
      //Check if the sensor has been covered for the specified amount of time
      if (timeElapsedFinger > targetSeconds) {
        println("photo q finished");
        questionCompleted(true, "finePhoto");
        countingStarted = false;
        keepGenerating = true;
        timeStarted = 0;
        timeElapsedFinger = 0;
      }
    } else {
      countingStarted = false;
    }
    
    //reset to original screen settings
    textAlign(LEFT);    
  }
  
  //Description: A counter that gets triggered when a finger is placed on the light sensor
  void startCounting() {
    countingStarted = true;
    timeStarted = millis()/1000;
  }
  
  //Description: Generates a random amount of seconds to prompt the user with
  int newQuestion(){
    keepGenerating = false; //Once this function is called, we can stop generating questions
    return int(random(2, 6));
  }
}

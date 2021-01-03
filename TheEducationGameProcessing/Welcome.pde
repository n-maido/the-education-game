/*
 * Welcome.pde
 *
 * Description: Displays the main menu, handles user input, and displays the selected question section
 *
 * Authors: Nhi Mai-Do, Steven Kobza
 *
*/
class Welcome {
  //Scene objects
  Arithmetic math;
  Emotion emote;
  FineMotorKnob fineKnob;
  FineMotorPhoto finePhoto;
  CorrectAnswer corr;
  IncorrectAnswer inCorr;
  
  //Vars to keep track of cur and prev scene
  public String currentScene;
  public String previousScene;
  
  //Cur and prev frame count
  int currentFC = 0;
  int previousFC;
  
  boolean timeForPhoto; //keeps track of when to move on to part 2 of our 2-part fine motor section
  int resultDisplayTime; //how many seconds to display our result screen for
  
  //button variables
  int buttonWidth;
  int buttonHeight;
  int buttonY;
  
  void setupWelcome() {
    //Initiate scene objects
    math = new Arithmetic();
    emote = new Emotion();
    fineKnob = new FineMotorKnob();
    finePhoto = new FineMotorPhoto();
    corr = new CorrectAnswer();
    inCorr = new IncorrectAnswer();
    
    currentScene = "";
    resultDisplayTime = 2; //we will display our result screen for 2 secs
    buttonWidth = 182;
    buttonHeight = 50;
    buttonY = 450;
  }
  
  //Description: Draws the main menu, displays the selected section
  void drawMe() {
    //Change to the appropriate section, according to the received input
    //Current Scene is the way we track which scene we're on.
    if (currentScene != "") {
      //Corr is correct Answer
      if (currentScene == "corr") {
         corr.drawMe();
         currentFC = frameCount;
         //Checks if it has been 2 seconds and then resets.
         if ((currentFC - previousFC) / 60 == resultDisplayTime) {
           currentScene = previousScene;
         }
         //InCorr is incorrect
      } else if (currentScene == "inCorr") {
        inCorr.drawMe();
        currentFC = frameCount;
        if ((currentFC - previousFC) / 60 == resultDisplayTime) {
          currentScene = previousScene;
        }
        //Recap displays the results after each section
      } else if (currentScene == "recap") {
        recap.drawMe();
        currentFC = frameCount;
        //Same 5 seconds except for the fine photo and stuff
        if ((currentFC - previousFC) / 60 == resultDisplayTime) {
          if (timeForPhoto == true) {
            currentScene = "finePhoto";
          } else {
            //If we end up here, we just draw the welcome screen
            currentScene = "";
          }
        }
        //Math section
      } else if (currentScene == "math") {
        math.drawMe();
        //Potentiometer section
      } else if (currentScene == "fineKnob") {
        fineKnob.drawKnob();
        //Photoresistor section
      } else if (currentScene == "finePhoto"){
        finePhoto.drawCounter();
      }
      //Emotion Section
      else if (currentScene == "emote"){
        emote.drawMe();
      }
    } else{
      //Draw the main menu
      background(255);
      
      //Welcome text
      fill(0);
      textSize(58);
      text("Welcome to The Education Game!", 100, 250);
      textSize(32);
      text("Please choose an option:", 100, 400);
      
      //Arithmetic button
      textSize(32);
      fill(255, 255, 0);
      rect(100, buttonY, buttonWidth, buttonHeight);
      fill(0);
      text("Arithmetic", 110, buttonY + 35);
      
      //Emotion button
      fill(0, 0, 255);
      rect(350, buttonY, buttonWidth, buttonHeight);
      fill(255);
      text("Emotions", 372, buttonY + 35);
      
      //Fine Motor button
      fill(255, 0, 0);
      rect(600, buttonY, buttonWidth, buttonHeight);
      fill(0);
      text("Fine Motor", 608, buttonY + 35);
      
      //Exit button
      fill(0, 255, 0);
      rect(850, buttonY, buttonWidth, buttonHeight);
      fill(0);
      text("Exit", 910, buttonY + 35);
    }
  }
  
  //Description: Checks button input for the main menu, sets the current scene to the corresponding section
  int checkInput() {    
    if (int(inputs.get("yellow button")) == 1) {      
      currentScene = "math";
      previousFC = frameCount;
      return 1;
    } else if (int(inputs.get("blue button")) == 1) {
      previousFC = frameCount;
      currentScene = "emote";
      return 2;
    } else if (int(inputs.get("red button")) == 1) {
      currentScene = "fineKnob";
      return 3;
    } else if (int(inputs.get("green button")) == 1) {
      exit();
    }
    return -1;
    
    
  }
  
  //Description: Changes scene according to the button that's been clicked. For bug testing on the computer, when you don't have access to the hardware. 
  int checkMouseInput() {
    if (mouseX <= 200 && mouseX >= 100 && mouseY <= 350 && mouseY >= 300) {
      currentScene = "math";
      previousFC = frameCount;
      return 1;
    } else if (mouseX <= 450 && mouseX >= 350 && mouseY <= 350 && mouseY >= 300) {
      currentScene = "emote";
      return 2;
    } else if (mouseX <= 700 && mouseX >= 600 && mouseY <= 350 && mouseY >= 300) {
      currentScene = "fineKnob";
      return 3;
      
    } else {
      return -1;
    }
  }
}

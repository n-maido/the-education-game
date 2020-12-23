class Welcome {
  Arithmetic math;
  Emotion emote;
  FineMotorKnob fineKnob;
  FineMotorPhoto finePhoto;
  CorrectAnswer corr;
  IncorrectAnswer inCorr;
  public String currentScene;
  public String previousScene;
  boolean timeForPhoto;
  int currentFC = 0;
  int previousFC;
  int resultDisplayTime; //how many seconds to display our results screens for
  
  //button variables
  int buttonWidth;
  int buttonHeight;
  int buttonY;
  
  void setupWelcome() {
    math = new Arithmetic();
    emote = new Emotion();
    fineKnob = new FineMotorKnob();
    finePhoto = new FineMotorPhoto();
    corr = new CorrectAnswer();
    inCorr = new IncorrectAnswer();
    currentScene = "";
    resultDisplayTime = 2;
    buttonWidth = 182;
    buttonHeight = 50;
    buttonY = 450;
  }
  
  void drawMe() {
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
        //Same 5 seconds
        if ((currentFC - previousFC) / 60 == resultDisplayTime) {
          currentScene = previousScene;
        }
        //Recap is the recap after each scene
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
      background(255);
      
      //welcome text
      fill(0);
      textSize(58);
      text("Welcome to The Education Game!", 100, 250);
      textSize(32);
      text("Please choose an option:", 100, 400);
      
      //draw arithmetic button
      textSize(32);
      fill(255, 255, 0);
      rect(100, buttonY, buttonWidth, buttonHeight);
      fill(0);
      text("Arithmetic", 110, buttonY + 35);
      
      //Emotion button
      fill(0, 0, 255);
      rect(350, buttonY, buttonWidth, buttonHeight);
      fill(0);
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
  
  int checkInput() {
    //Checking input for the welcome screen
    if (int(inputs.get("yellow button")) == 1) {      
      changeScene("math");
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
  int checkMouseInput() {
    if (mouseX <= 200 && mouseX >= 100 && mouseY <= 350 && mouseY >= 300) {
      changeScene("math");
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
  
  void correctInput() {
    corr.drawMe();
  }
  
  void incorrectInput() {
  }
}

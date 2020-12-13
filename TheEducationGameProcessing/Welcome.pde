class Welcome {
  Arithmetic math;
  Emotion emote;
  FineMotor fineKnob;
  FineMotorPhoto finePhoto;
  correctAnswer corr;
  inCorrectAnswer inCorr;
  public String currentScene;
  public String previousScene;
  boolean timeForPhoto;
  int currentFC = 0;
  int previousFC;
  int resultDisplayTime; //how many seconds to display our results screens for
  
  //button variables
  int buttonWidth;
  int buttonHeight;
  
  void setupWelcome() {
    math = new Arithmetic();
    emote = new Emotion();
    fineKnob = new FineMotor();
    finePhoto = new FineMotorPhoto();
    corr = new correctAnswer();
    inCorr = new inCorrectAnswer();
    currentScene = "";
    resultDisplayTime = 2;
    buttonWidth = 182;
    buttonHeight = 50;
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
      fill(0, 0, 0);
      textSize(32);
      text("Hello", 200, 200);
      //draw arithmetic button
      fill(255, 255, 0);
      rect(100, 300, buttonWidth, buttonHeight);
      fill(0);
      text("Arithmetic", 110, 335);
      //Emotion button
      fill(0, 0, 255);
      rect(350, 300, buttonWidth, buttonHeight);
      fill(0);
      text("Emotions", 392.5, 335);
      //Fine Motor button
      fill(255, 0, 0);
      rect(600, 300, buttonWidth, buttonHeight);
      fill(0);
      text("Fine Motor", 642.5, 335);
      //Exit button
      fill(0, 255, 255);
      rect(850, 300, buttonWidth, buttonHeight);
      fill(0);
      text("Exit", 892.5, 335);
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

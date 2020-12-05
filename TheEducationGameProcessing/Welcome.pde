class Welcome {
  Arithmetic math;
  Emotion emote;
  FineMotor fine;
  correctAnswer corr;
  inCorrectAnswer inCorr;
  public String currentScene;
  
  int currentFC = 0;
  int previousFC;
  
  void setupWelcome() {
    math = new Arithmetic();
    emote = new Emotion();
    fine = new FineMotor();
    corr = new correctAnswer();
    inCorr = new inCorrectAnswer();
    currentScene = "";
  }
  
  void drawMe() {
    if (currentScene != "") {
      if (currentScene == "corr") {
         corr.drawMe();
         currentFC = frameCount;
         if ((currentFC - previousFC) / 60 == 5) {
           currentScene = "";
         }
      } else if (currentScene == "inCorr") {
        inCorr.drawMe();
        currentFC = frameCount;
        if ((currentFC - previousFC) / 60 == 5) {
          currentScene = "";
        }
      } else if (currentScene == "math") {
        math.drawMe();
      } else if (currentScene == "fine") {
        fine.drawMe();
      } else if (currentScene == "emote") {
        emote.drawMe();
      }
    } else{
      background(255);
      fill(0, 0, 0);
      textSize(32);
      text("Hello", 200, 200);
      fill(255, 255, 0);
      rect(100, 300, 100, 50);
      fill(0);
      text("1", 142.5, 335);
      fill(0, 0, 255);
      rect(350, 300, 100, 50);
      fill(0);
      text("2", 392.5, 335);
      fill(255, 0, 0);
      rect(600, 300, 100, 50);
      fill(0);
      text("3", 642.5, 335);
    }
  }
  
  int checkInput() {
    print("yellow: " + int(inputs.get("yellow button")));
    if (int(inputs.get("yellow button")) == 1) {
      
      changeScene("math");
      previousFC = frameCount;
      return 1;
    } else if (int(inputs.get("blue button")) == 1) {
      
      currentScene = "emote";
      return 2;
    } else if (int(inputs.get("red button")) == 1) {
      
      currentScene = "fine";
      return 3;
    } else {
      return -1;
    }
    /*
    if (mouseX <= 200 && mouseX >= 100 && mouseY <= 350 && mouseY >= 300) {
      changeScene("math");
      previousFC = frameCount;
      return 1;
    } else if (mouseX <= 450 && mouseX >= 350 && mouseY <= 350 && mouseY >= 300) {
      currentScene = "emote";
      return 2;
    } else if (mouseX <= 700 && mouseX >= 600 && mouseY <= 350 && mouseY >= 300) {
      currentScene = "fine";
      return 3;
      
    } else {
      return -1;
    }*/
  }
  
  void correctInput() {
    corr.drawMe();
  }
  
  void incorrectInput() {
  }
}

import processing.serial.*;

Serial myPort;
Welcome welc;
correctAnswer corr;
public StringDict inputs;
byte[] inBuffer = new byte[255];
int port = 1;
int numQuestions = 3;
int questionsCompleted;
public ArrayList<Boolean> questions;
AnswerRecap recap;

void setup() {
  size(800, 600);
  printArray(Serial.list());
  //check for the current OS and open the appropriate port
  if (System.getProperty("os.name").contains("Windows")) {
    //port = 1;
    port = 0;
  } else {
    port = 3;
  }
  myPort = new Serial(this, Serial.list()[port], 9600); //mod to serial port of my comp
  //Creating a welcome scene and setting it up
  welc = new Welcome();
  welc.setupWelcome();
  corr = new correctAnswer();
  //Setting up the string dictionary to track the button inputs
  inputs = new StringDict();
  frameRate(60);
  inputs.set("yellow button", "0");
  inputs.set("blue button", "0");
  inputs.set("red button", "0");
  inputs.set("green button", "0");
  //Setting up the arraylist to track the questions
  questions = new ArrayList<Boolean>();
  //Test questions that get deleted
  questions.add(true);
  questions.add(false);
  questions.add(true);
  recap = new AnswerRecap();
}

void draw() {
  background(#ffffff);
  if(myPort.available() > 0) {
    //Reading the bytes until our break character in the arduino code
    myPort.readBytesUntil('&', inBuffer);
    if(inBuffer != null){
      String inByte = new String(inBuffer);
      getInputOfSerial(inByte);
      
    }
    
  }
  //Drawing the welcome scene
  welc.drawMe();
  //Checking the input. Two different scenes need different inputs so need two different functions
  if (welc.currentScene == "") {
    welc.checkInput();
  } else if (welc.currentScene == "emote") {
    welc.currentFC = frameCount;
    if ((welc.currentFC - welc.previousFC) / 60 == 5) {
        welc.emote.checkInput();
    }
  }
}
void mouseClicked() {
  //For bug testing on the computer that doesn't have the arduino
  if (welc.currentScene == "") {
    welc.checkMouseInput();
  } else if (welc.currentScene == "emote") {
    //welc.emote.checkInput();
  }
}

void getInputOfSerial(String inByte) {
  //Splitting strings based on the index of the splitting variables
  //Yellow button
  int tempYellow = inByte.indexOf("y");
  int tempEndYellow = inByte.indexOf("y", tempYellow+1);
  if (tempYellow != -1) {
    inputs.set("yellow button", inByte.substring(tempYellow +1, tempEndYellow));
  }
  //blue button
  int tempBlue = inByte.indexOf("b");
  int tempEndBlue = inByte.indexOf("b", tempBlue+1);
  if (tempBlue != -1) {
    inputs.set("blue button", inByte.substring(tempBlue + 1, tempEndBlue)); //Blue starts and ends at same index, and so on for the rest of the inputs
  }
  //red button
  int tempRed = inByte.indexOf("r");
  int tempEndRed = inByte.indexOf("r", tempRed+1);
  if (tempRed != -1) {
    inputs.set("red button", inByte.substring(tempRed + 1, tempEndRed));
  }
  //green button
  int tempGreen = inByte.indexOf("g");
  int tempEndGreen = inByte.indexOf("g", tempGreen+1);
  if (tempGreen != -1) {
    inputs.set("green button", inByte.substring(tempGreen + 1, tempEndGreen));
  }
  //photo resistor
  int tempPhoto = inByte.indexOf("a");
  int tempEndPhoto = inByte.indexOf("a", tempPhoto+1);
  if (tempPhoto != -1) {
    inputs.set("photoresistor", inByte.substring(tempPhoto + 1, tempEndPhoto));
  }
  //potentiometer
  int tempPotent = inByte.indexOf("z");
  int tempEndPotent = inByte.indexOf("z", tempPotent+1);
  if (tempPotent != -1) {
    inputs.set("potentiometer", inByte.substring(tempPotent + 1, tempEndPotent));
  }
}

public void changeScene(String newScene) {
  //Function to change scene so that it's easier to do
  welc.currentScene = newScene;
  welc.previousFC = frameCount;
}

public void questionCompleted(boolean correct, String scene) {
  //Function to track which questions are correct
  questionsCompleted++;
  println("questions completed: " + questionsCompleted);
  //If it's true, add a true to the arraylist and then set the scene passed to be the previous scene. Otherwise add a false and do the same thing. Corr is the correctAnswer scene, inCorr is incorrect.
  if (correct == true) {
    questions.add(true);
    welc.previousScene = scene;
    changeScene("corr");
  } else if (correct == false) {
    questions.add(false);
    welc.previousScene = scene;
    changeScene("inCorr");
  }
  //If the number of questions is equal to the set amount of questions you're to do per section then it runs the recap.
  if (questionsCompleted == numQuestions && scene != "fineKnob" && scene != "finePhoto") {
    println("knob and photo completed");
    recap.resetQuestions();
    welc.previousFC = frameCount;
    welc.currentScene = "recap";
    questionsCompleted = 0;
  } else if (questionsCompleted == numQuestions && scene == "fineKnob") {
    //If you're on either the potentiometer or the photoresistor. Things change. with the potentiometer, you need to go the photoresistor afterwards, so we tracked that using a variable named "time for photo" after that you need to reset it.
    welc.timeForPhoto = true;
    recap.resetQuestions();
    welc.previousFC = frameCount;
    welc.currentScene = "recap";
    questionsCompleted = 0;
  } else if (questionsCompleted % numQuestions == 0 && scene == "finePhoto") {
    println("photo completed");
    welc.timeForPhoto = false;
    recap.resetQuestions();
    welc.previousFC = frameCount;
    welc.currentScene = "recap";
    questionsCompleted = 0;
  }
}

void keyPressed() {
  switch(welc.currentScene) {
    case "math":
      welc.math.mathKeyPressed(key);
  }
}

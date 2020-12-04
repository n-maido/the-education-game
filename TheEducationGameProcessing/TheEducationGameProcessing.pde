import processing.serial.*;

Serial myPort;
Welcome welc;
correctAnswer corr;
public StringDict inputs;

void setup() {
  size(800, 600);
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[3], 9600); //mod to serial port of my comp
  welc = new Welcome();
  welc.setupWelcome();
  corr = new correctAnswer();
  inputs = new StringDict();
  frameRate(60);
}

void draw() {
  background(#ffffff);
  if(myPort.available() > 0) { //changed from while to if, in order to print troubleshooting statement; draw is a loop anyways
    String inByte = myPort.readStringUntil('&');
    println(inByte);
    getInputOfSerial(inByte);
    
  }
  else println("nothing available");//troubleshooting
  welc.drawMe();
}
void mouseClicked() {
  if (welc.currentScene == "") {
    welc.checkInput();
  } else if (welc.currentScene == "emote") {
    welc.emote.checkInput();
  }
}

void getInputOfSerial(String inByte) {
  int tempYellow = inByte.indexOf("y");
  int tempEndYellow = inByte.indexOf("y", tempYellow);
  //--troubleshooting--
  println("yellow starts at " + tempYellow + " and ends at " + tempEndYellow);
  //inputs.set("yellow button", inByte.substring(tempYellow + 1, tempEndYellow - 1)); //StringIndexOutOfBoundsException: tempYellow is index 0, tempEndYellow is index 0!
  int tempBlue = inByte.indexOf("b");
  int tempEndBlue = inByte.indexOf("b", tempBlue);
  println("blue starts at " + tempBlue + " and ends at " + tempEndBlue); //troubleshooting
  //inputs.set("blue button", inByte.substring(tempBlue + 1, tempEndBlue - 1)); //Blue starts and ends at same index, and so on for the rest of the inputs
  int tempRed = inByte.indexOf("r");
  int tempEndRed = inByte.indexOf("r", tempRed);
  println("red starts at " + tempRed + " and ends at " + tempEndRed); //troubleshooting
  inputs.set("red button", inByte.substring(tempRed + 1, tempEndRed - 1));
  int tempGreen = inByte.indexOf("g");
  int tempEndGreen = inByte.indexOf("g", tempGreen);
  inputs.set("green button", inByte.substring(tempGreen + 1, tempEndGreen - 1));
  int tempPhoto = inByte.indexOf("a");
  int tempEndPhoto = inByte.indexOf("a", tempPhoto);
  inputs.set("photoresistor", inByte.substring(tempPhoto + 1, tempEndPhoto - 1));
  int tempPotent = inByte.indexOf("z");
  int tempEndPotent = inByte.indexOf("z", tempPotent);
  inputs.set("potentiometer", inByte.substring(tempPotent + 1, tempEndPotent - 1));
}

public void changeScene(String newScene) {
  welc.currentScene = newScene;
  welc.previousFC = frameCount;
}

void keyPressed() {
  switch(welc.currentScene) {
    case "math":
      welc.math.mathKeyPressed(key);
  }
}

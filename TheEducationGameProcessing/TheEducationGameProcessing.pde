import processing.serial.*;

Serial myPort;
Welcome welc;
correctAnswer corr;
public StringDict inputs;

void setup() {
  size(800, 600);
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  welc = new Welcome();
  welc.setupWelcome();
  corr = new correctAnswer();
  inputs = new StringDict();
  frameRate(60);
}

void draw() {
  background(#ffffff);
  while(myPort.available() > 0) {
    String inByte = myPort.readStringUntil('&');
    println(inByte);
    getInputOfSerial(inByte);
    
  }
  welc.drawMe();
}
void mouseClicked() {
  switch(welc.checkInput()) {
    case 1:
    case 2:
    case 3:
  }
}

void getInputOfSerial(String inByte) {
  int tempYellow = inByte.indexOf("y");
  int tempEndYellow = inByte.indexOf("y", tempYellow);
  inputs.set("yellow button", inByte.substring(tempYellow + 1, tempEndYellow - 1));
  int tempBlue = inByte.indexOf("b");
  int tempEndBlue = inByte.indexOf("b", tempBlue);
  inputs.set("blue button", inByte.substring(tempBlue + 1, tempEndBlue - 1));
  int tempRed = inByte.indexOf("r");
  int tempEndRed = inByte.indexOf("r", tempRed);
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
}

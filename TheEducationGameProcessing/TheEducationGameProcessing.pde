import processing.serial.*;

Serial myPort;
Welcome welc;
correctAnswer corr;
public StringDict inputs;
byte[] inBuffer = new byte[255];
int port = 1;

void setup() {
  size(800, 600);
  printArray(Serial.list());
  if (System.getProperty("os.name").contains("Windows")) {
    port = 1;
  } else {
    port = 3;
  }
  myPort = new Serial(this, Serial.list()[port], 9600); //mod to serial port of my comp
  welc = new Welcome();
  welc.setupWelcome();
  corr = new correctAnswer();
  inputs = new StringDict();
  frameRate(60);
  inputs.set("yellow button", "0");
  inputs.set("blue button", "0");
  inputs.set("red button", "0");
  inputs.set("green button", "0");
}

void draw() {
  background(#ffffff);
  if(myPort.available() > 0) { //changed from while to if, in order to print troubleshooting statement; draw is a loop anyways
    /*
    String inByte = myPort.readStringUntil('&');
    println(inByte);//prints null; works fine if I comment out the line below
    getInputOfSerial(inByte);
    */
    //No null input when I do it this way
    myPort.readBytesUntil('&', inBuffer);
    if(inBuffer != null){
      String inByte = new String(inBuffer); //"b150.0b\ny156.0y";
      println(inByte);
      getInputOfSerial(inByte);
      
    }
    
  }
  else println("nothing available");//troubleshooting
  
  
  welc.drawMe();
  if (welc.currentScene == "") {
    welc.checkInput();
  } else if (welc.currentScene == "emote") {
    welc.emote.checkInput();
  }
}
void mouseClicked() {
  if (welc.currentScene == "") {
    welc.checkInput();
  } else if (welc.currentScene == "emote") {
    welc.emote.checkInput();
  }
}

void getInputOfSerial(String inByte) {
  int tempYellow = inByte.indexOf("y"); //(Thinkpad) NullPointerException
  int tempEndYellow = inByte.indexOf("y", tempYellow+1); //mod: start at 1 past tempYellow so search doesn't stop immediately
  //--troubleshooting--
  //println("yellow starts at " + tempYellow + " and ends at " + tempEndYellow);
  if (tempYellow != -1) {
    //println(inByte.substring(tempYellow + 1, tempEndYellow));
    inputs.set("yellow button", inByte.substring(tempYellow +1, tempEndYellow));
  }
  
  //println("I think yellow is " + inByte.substring(tempYellow + 1, tempEndYellow - 1));
  //println("I think yellow is " + inByte.substring(tempYellow + 1, tempEndYellow - 1));
  //inputs.set("yellow button", inByte.substring(tempYellow + 1, tempEndYellow - 1)); //(Mac) StringIndexOutOfBoundsException: tempYellow is index 0, tempEndYellow is index 0!
  
  int tempBlue = inByte.indexOf("b");
  int tempEndBlue = inByte.indexOf("b", tempBlue+1);
  if (tempBlue != -1) {
    //println("blue starts at " + tempBlue + " and ends at " + tempEndBlue); //troubleshooting
    //println(inByte.substring(tempBlue+1, tempEndBlue));
    inputs.set("blue button", inByte.substring(tempBlue + 1, tempEndBlue)); //Blue starts and ends at same index, and so on for the rest of the inputs
  }
  
  int tempRed = inByte.indexOf("r");
  int tempEndRed = inByte.indexOf("r", tempRed+1);
  //println("red starts at " + tempRed + " and ends at " + tempEndRed); //troubleshooting
  if (tempRed != -1) {
    inputs.set("red button", inByte.substring(tempRed + 1, tempEndRed));
  }
  
  int tempGreen = inByte.indexOf("g");
  int tempEndGreen = inByte.indexOf("g", tempGreen+1);
  if (tempGreen != -1) {
    inputs.set("green button", inByte.substring(tempGreen + 1, tempEndGreen));
  }
  int tempPhoto = inByte.indexOf("a");
  int tempEndPhoto = inByte.indexOf("a", tempPhoto+1);
  if (tempPhoto != -1) {
    inputs.set("photoresistor", inByte.substring(tempPhoto + 1, tempEndPhoto));
  }
  int tempPotent = inByte.indexOf("z");
  int tempEndPotent = inByte.indexOf("z", tempPotent+1);
  if (tempPotent != -1) {
    inputs.set("potentiometer", inByte.substring(tempPotent + 1, tempEndPotent));
  }
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

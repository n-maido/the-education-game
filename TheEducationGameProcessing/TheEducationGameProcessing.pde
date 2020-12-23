/*
 * TheEducationGameProcessing.pde
 *
 * Description: Handles serial communication, handles scene changes, and keeps track of completed questions and answers
 *
 * Authors: Nhi Mai-Do, Steven Kobza
 *
*/
import processing.serial.*;

//Serial vars
Serial myPort;
byte[] inBuffer = new byte[255];
int port = 1;

//Scene objects
Welcome welc;
CorrectAnswer corr;
AnswerRecap recap; 

//Question-handling vars
public StringDict inputs;
int numQuestions = 3;
int questionsCompleted;
public ArrayList<Boolean> questions;


void setup() {
  size(1132, 700); 
  
  //Set up serial communication
  printArray(Serial.list());
  //check for the current OS and open the appropriate port
  if (System.getProperty("os.name").contains("Windows")) {
    port = 1; //change to your computer's serial port
  } else {
    port = 3;
  }
  myPort = new Serial(this, Serial.list()[port], 9600);
  
  //Initialize welcome and answer screens
  welc = new Welcome();
  welc.setupWelcome();
  corr = new CorrectAnswer();
  
  //Set up the string dictionary to track the button inputs
  inputs = new StringDict();
  frameRate(60);
  inputs.set("yellow button", "0");
  inputs.set("blue button", "0");
  inputs.set("red button", "0");
  inputs.set("green button", "0");
  
  //Set up the arraylist to track the questions
  questions = new ArrayList<Boolean>();
  //Initialize recap screen
  recap = new AnswerRecap();
}

void draw() {
  background(255);
  
  //Read serial input
  if(myPort.available() > 0) {
    //Read the bytes until our break character in the arduino code
    myPort.readBytesUntil('&', inBuffer);
    if(inBuffer != null){
      String inByte = new String(inBuffer);
      getInputOfSerial(inByte);     
    }   
  }
  
  //Draw welcome scene
  welc.drawMe();
  //Check the input. Two different scenes need different inputs, so we need two different functions
  if (welc.currentScene == "") {
    welc.checkInput(); 
  } 
  else if (welc.currentScene == "emote") {
    welc.currentFC = frameCount; 
  }
  
}

//Description: Checks if the on-screen buttons have been clicked. For bug testing on the computer, when you don't have access to the hardware. 
void mouseClicked() {
  if (welc.currentScene == "") {
    welc.checkMouseInput();
  } else if (welc.currentScene == "emote") {
    welc.emote.checkInput();
  }
}

//Description: Reads incoming data from the serial port
void getInputOfSerial(String inByte) {
  //Splitting strings based on the index of the splitting variables
  //yellow button
  int tempYellow = inByte.indexOf("y");
  int tempEndYellow = inByte.indexOf("y", tempYellow+1);
  if (tempYellow != -1) {
    inputs.set("yellow button", inByte.substring(tempYellow +1, tempEndYellow));
  }
  //blue button
  int tempBlue = inByte.indexOf("b");
  int tempEndBlue = inByte.indexOf("b", tempBlue+1);
  if (tempBlue != -1) {
    inputs.set("blue button", inByte.substring(tempBlue + 1, tempEndBlue));
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
  //photoresistor
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

//Description: Displays the requested screen
public void changeScene(String newScene) {
  welc.currentScene = newScene;
  welc.previousFC = frameCount;
}

//Description: Keep track of completed questions
public void questionCompleted(boolean correct, String scene) {
  questionsCompleted++;
  println("questions completed: " + questionsCompleted);//for troubleshooting
  
  //If we received a correct answer, add a "true" to the arraylist, otherwise add a "false". Then, set the scene passed to be the previous scene. 
  //Corr is the correctAnswer scene, inCorr is incorrect.
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
    recap.resetQuestions();
    welc.previousFC = frameCount;
    welc.currentScene = "recap";
    questionsCompleted = 0;
  
  //Check if we're in the potentiometer section
  } else if (questionsCompleted == numQuestions && scene == "fineKnob") {
    //A different way of handling scene changes is required in the potentiometer section.
    //In the potentiometer section, we need to go the photoresistor afterwards, so we tracked that using a variable named "time for photo".
    //After that, we reset the scene and questions
    welc.timeForPhoto = true;
    recap.resetQuestions();
    welc.previousFC = frameCount;
    welc.currentScene = "recap"; //move on to the question recap scene
    questionsCompleted = 0; //reset questions
    
  //Check if we're in the photoresistor section
  } else if (questionsCompleted % numQuestions == 0 && scene == "finePhoto") {
    println("photo completed");
    welc.timeForPhoto = false;
    recap.resetQuestions();
    welc.previousFC = frameCount;
    welc.currentScene = "recap";
    questionsCompleted = 0;
  }
}

//Description: Checks for keyboard inputs
void keyPressed() { 
  switch(welc.currentScene) {
    case "math":
      welc.math.mathKeyPressed(key);
  }
}

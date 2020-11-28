import processing.serial.*;

Serial myPort;
Welcome welc;
correctAnswer corr;

void setup() {
  size(800, 600);
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  welc = new Welcome();
  corr = new correctAnswer();
}

void draw() {
  background(#ffffff);
  while(myPort.available() > 0) {
    String inByte = myPort.readStringUntil('&');
    println(inByte);
    
  }
  //welc.drawMe();
  corr.drawMe();
}
void mouseClicked() {
  switch(welc.checkInput()) {
    case 1:
    case 2:
    case 3:
  }
}

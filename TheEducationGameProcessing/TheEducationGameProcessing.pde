import processing.serial.*;

Serial myPort;
Welcome welc;

void setup() {
  size(800, 600);
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  welc = new Welcome();
}

void draw() {
  background(#ffffff);
  while(myPort.available() > 0) {
    String inByte = myPort.readStringUntil('&');
    println(inByte);
    
  }
  welc.drawMe();
}
void mouseClicked() {
  println(welc.checkInput());
}

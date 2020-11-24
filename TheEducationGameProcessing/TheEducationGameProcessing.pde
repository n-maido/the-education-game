import processing.serial.*;

Serial myPort;

void setup() {
  size(800, 600);
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  background(#ffffff);
  while(myPort.available() > 0) {
    int inByte = myPort.read();
    println(inByte);
  }
}

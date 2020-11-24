
//Buttons that don't change in the code.
const int yellowButtonPin = 9;
const int blueButtonPin = 10;
const int redButtonPin = 11;
const int greenButtonPin = 12;

//Potentiometer Pin
const int potentiometerWiper = A0;

//Photoresistor Pin
const int photoresistorPin = A1;

//Button Variables
int yellowBut;
int blueBut;
int greenBut;
int redBut;

//Analog Variables
double poten;
double photoR;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(yellowButtonPin, INPUT);
  pinMode(blueButtonPin, INPUT);
  pinMode(redButtonPin, INPUT);
  pinMode(greenButtonPin, INPUT);

  
}

void loop() {
  // put your main code here, to run repeatedly:
  yellowBut = digitalRead(yellowButtonPin);
  blueBut = digitalRead(blueButtonPin);
  redBut = digitalRead(redButtonPin);
  greenBut = digitalRead(greenButtonPin);

  poten = analogRead(potentiometerWiper);
  photoR = analogRead(photoresistorPin);
}

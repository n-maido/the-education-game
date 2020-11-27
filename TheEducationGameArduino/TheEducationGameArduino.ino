
//Buttons that don't change in the code.
const int yellowButtonPin = 9;
const int blueButtonPin = 10;
const int redButtonPin = 11;
const int greenButtonPin = 12;

//Potentiometer Pin
const int potentiometerWiper = A0;

//Photoresistor Pin
const int photoresistorPin = A1;

//Button Variables; stores input values
int yellowInput;
int blueInput;
int greenInput;
int redInput;

//Analog Variables to store input from sensors
double potentInput;
double photoInput;

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
  //Read inputs
  yellowInput = digitalRead(yellowButtonPin);
  blueInput = digitalRead(blueButtonPin);
  redInput = digitalRead(redButtonPin);
  greenInput = digitalRead(greenButtonPin);

  potentInput = analogRead(potentiometerWiper);
  photoInput = analogRead(photoresistorPin);

  //packet the 6 inputs

  //yellow button (delimited by 'y')
  Serial.print("y"); 
  Serial.print(photoInput);
  Serial.print("y");
  Serial.println();

  //blue button (delimited by 'b')
  Serial.print("b"); 
  Serial.print(photoInput);
  Serial.print("b");
  Serial.println();

  //red button (delimited by 'r')
  Serial.print("r"); 
  Serial.print(photoInput);
  Serial.print("r");
  Serial.println();

  //green button (delimited by 'g')
  Serial.print("g"); 
  Serial.print(photoInput);
  Serial.print("g");
  Serial.println();

  //photoresistor (delimited by 'a')
  Serial.print("a"); 
  Serial.print(photoInput);
  Serial.print("a");
  Serial.println();

  //potentiometer (delimited by 'z')
  Serial.print("z"); 
  Serial.print(potentInput);
  Serial.print("z");
  Serial.println();

  //end of input
  Serial.print("&");
  Serial.println();
  delay(100);
}

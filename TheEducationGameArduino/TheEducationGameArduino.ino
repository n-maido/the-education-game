
//LED pins
const int yellowLed = 4;
const int blueLed = 5;
const int redLed = 6;
const int greenLed = 7;


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
  
  //set LEDs to output
  pinMode(yellowLed, OUTPUT);
  pinMode(blueLed, OUTPUT);
  pinMode(redLed, OUTPUT);
  pinMode(greenLed, OUTPUT);
  
  
  //set buttons to input
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

  //turn on LEDs when their corresponding buttons are pressed
  turnOnLeds();

  //packet the 6 inputs
  packageInputs();
  
}

//function to turn on LEDs when buttons are pressed
void turnOnLeds(){
  //yellow
  if(yellowInput == HIGH){
    digitalWrite(yellowLed, HIGH);
  }
  else{
    digitalWrite(yellowLed, LOW);
  }
  //blue
  if(blueInput == LOW){
    digitalWrite(blueLed, HIGH);
  }
  else{
    digitalWrite(blueLed, LOW);
  }
  //red
  if(redInput == LOW){
    digitalWrite(redLed, HIGH);
  }
  else{
    digitalWrite(redLed, LOW);
  }
  //green
  if(greenInput == LOW){
    digitalWrite(greenLed, HIGH);
  }
  else{
    digitalWrite(greenLed, LOW);
  }  
}

//function to package inputs
void packageInputs(){
  String serialOutput = "";
  //serialOutput += "y";
  //serialOutput += String(photoInput);
  //serialOutput += "y";
  //yellow button (delimited by 'y')
  Serial.print("y"); 
  Serial.print(yellowInput);
  Serial.print("y");
  Serial.println();

  //serialOutput += "b";
  //serialOutput += String(photoInput);
  //serialOutput += "b";
  //blue button (delimited by 'b')
  Serial.print("b"); 
  Serial.print(blueInput);
  Serial.print("b");
  Serial.println();

  //serialOutput += "r";
  //serialOutput += String(photoInput);
  //serialOutput += "r";
  //red button (delimited by 'r')
  Serial.print("r"); 
  Serial.print(redInput);
  Serial.print("r");
  Serial.println();

  //serialOutput += "g";
  //serialOutput += String(photoInput);
  //serialOutput += "g";
  //green button (delimited by 'g')
  Serial.print("g"); 
  Serial.print(greenInput);
  Serial.print("g");
  Serial.println();

  //serialOutput += "a";
  //serialOutput += String(photoInput);
  //serialOutput += "a";
  //photoresistor (delimited by 'a')
  Serial.print("a"); 
  Serial.print(photoInput);
  Serial.print("a");
  Serial.println();

  //serialOutput += "z";
  //serialOutput += String(potentInput);
  //serialOutput += "z";
  //potentiometer (delimited by 'z')
  Serial.print("z"); 
  Serial.print(potentInput);
  Serial.print("z");
  Serial.println();

  //serialOutput += "&";
  //end of input
  Serial.print("&");
  Serial.println();
  delay(100);
}

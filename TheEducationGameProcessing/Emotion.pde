/*
 * Arithmetic.pde
 *
 * Description: The emotion recognition section. Draws a randomized cartoon facial expression, taking button inputs as a response
 *
 * Authors: Nhi Mai-Do, Steven Kobza
 *
*/

class Emotion {
  //question variables
  ArrayList<String> emotionOptions = new ArrayList<String>(); //store each emotion option in an array
  String correctEmotion;
  String answerChosen; //user input  
  int randomEmotion; //a randomly generated int that determines which emotion to display
  boolean keepGenerating = true; //this bool will toggle our question generator on/off
  
  //button specs
  int textY; //y-coord of our button text
  int buttonY; //y-coord of our button
  int centerButtonX; //x-coord of the center button
  
  //template specs
  int faceX;
  int faceY;
  int faceWidth;
  
  Emotion() {
    setupEmotions(emotionOptions);//Fill our array with options
    answerChosen = "";
    textY = height * 3/4;
    buttonY = textY - 32;
    centerButtonX = width/2-50;
  }
  
  //Description: Displays the question, the answer buttons, and verifies input
  void drawMe() {
    //display buttons/options
    background(255);
    fill(0, 0, 0);
    fill(255, 255, 0);
    
    //happy button
    rect(centerButtonX - 200, buttonY, 100, 50); 
    textSize(25);
    fill(0);
    text(emotionOptions.get(0), centerButtonX - 187, textY); 
    fill(0, 0, 255);
    
    //sad button
    rect(centerButtonX, buttonY, 100, 50); 
    fill(255);
    text(emotionOptions.get(1), centerButtonX + 27, textY); 
    fill(255, 0, 0);
    
    //angry button
    rect(centerButtonX + 200, buttonY, 100, 50); 
    fill(0);
    text(emotionOptions.get(2), centerButtonX + 217, textY); 
    
    //draw a blank face
    drawBlankFace();
    
    //choose an emotion to display
    if (keepGenerating == true){ //This bool will always be true upon launch. Every time we enter an emotion section, we generate a new question
      randomEmotion = generateEmotion();
    }
    
    //display the chosen emotion
    switch(randomEmotion){
      case 0:
        addHappyFeatures();
        correctEmotion = emotionOptions.get(0);
        break;
      case 1:
        addSadFeatures();
        correctEmotion = emotionOptions.get(1);
        break;
      case 2:
        addAngryFeatures();
        correctEmotion = emotionOptions.get(2);
        break;
    }
      
    //check input after a delay of 1 sec   
    if((welc.currentFC - welc.previousFC)/60 >= 1){
      checkInput();
    }
  }
  
  //Description: Generates a random emotion, by generating a random int between 0 and 2
  int generateEmotion() {
    keepGenerating = false; //Once this function is called, we can stop generating questions
    randomEmotion = int(random(0,2)); //The number we generate corresponds to the array index that the emotions are stored at
    println("We generated emotion " + randomEmotion);
    return randomEmotion;
  }
  
  //Description: Appends our emotion options to an array
  void setupEmotions(ArrayList<String> emotionOptions) {
    emotionOptions.add("happy");
    emotionOptions.add("sad");
    emotionOptions.add("angry");
  }
  
  //Description: Checks if user's answer is correct. Concludes the question by calling questionCompleted() and resetting variables
  void checkInput() {
    //Checks which button was pressed and sets the user's answer accordingly
    if (int(inputs.get("yellow button")) == 1) {
      answerChosen = emotionOptions.get(0);
    } else if (int(inputs.get("blue button")) == 1) {
      answerChosen = emotionOptions.get(1);
    } else if (int(inputs.get("red button")) == 1) {
      answerChosen = emotionOptions.get(2);
    }
    
    //Concludes the question
    if (answerChosen != "") {
      welc.previousFC = frameCount;
      if(answerChosen == correctEmotion) {        
        questionCompleted(true, "emote");
        keepGenerating = true; //we reset this so that it will always be true upon launch
        answerChosen = "";
      } else {
        questionCompleted(false, "emote");
        keepGenerating = true;
        answerChosen = "";
      }
    }
  }
  
  void drawBlankFace(){
    stroke(0);
    strokeWeight(2);
    fill(255, 255, 0);
    
    //draw face
    faceX = width/2;
    faceY = height/3;
    faceWidth = width/3;
    
    ellipse(faceX, faceY, faceWidth, faceWidth);
    
    //draw eyes
    fill(0);
    ellipse(faceX*7/8, faceY, 20, 20);
    ellipse(faceX*9/8, faceY, 20, 20);
  }
  
  void addHappyFeatures(){
    noFill();
    stroke(0);
    strokeWeight(2);
    //draw mouth
    arc(faceX, faceY+(faceWidth/6), faceWidth/2.5, faceWidth/4, 0, PI);
    strokeWeight(1);
  }
  
  void addSadFeatures(){
    noFill();
    stroke(0);
    strokeWeight(2);
    //draw mouth
    arc(faceX, faceY+(faceWidth/4), faceWidth/2.5, faceWidth/4, PI, 2*PI);
    strokeWeight(1);
  }
  
  void addAngryFeatures(){
    noFill();
    stroke(0);
    strokeWeight(2);
    
    //draw mouth
    line(faceX*7/8, faceY+(faceWidth/4), faceX*9/8, faceY+(faceWidth/4));
    
    //draw eyebrows
    line((faceX*7/8)-5, faceY*6/7, faceX-15, faceY);
    line(faceX+15, faceY, (faceX*9/8)+5, faceY*6/7);
    
    strokeWeight(1); //reset stroke
  }
}

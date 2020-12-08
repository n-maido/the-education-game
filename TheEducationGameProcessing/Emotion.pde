class Emotion {
  ArrayList<PImage> photos = new ArrayList<PImage>();
  ArrayList<String> emotions = new ArrayList<String>();
  ArrayList<ArrayList<String>> emotionChoices = new ArrayList<ArrayList<String>>();
  int currentPhoto = 0;
  String answerChosen = "";
  
  int question;
  boolean keepGenerating = true;
  
  //button specs
  int textY; //y-coord of our button text
  int buttonY; //y-coord of our button
  
  //template specs
  int faceX;
  int faceY;
  int faceWidth;
  
  Emotion() {
    setupPhotos();
    setupEmotions();
    textY = height * 3/4;
    buttonY = textY - 25;
  }
  
  void drawMe() {
    //display buttons/options
    background(255);
    fill(0, 0, 0);
    fill(255, 255, 0);
    rect(100, buttonY, 100, 50); //happy button
    textSize(25);
    fill(0);
    text(emotionChoices.get(currentPhoto).get(0), 100+20, textY); //option 1: happy
    fill(0, 0, 255);
    rect(350, buttonY, 100, 50); //sad button
    fill(255);
    text(emotionChoices.get(currentPhoto).get(1), 350+20, textY); //option 2: sad
    fill(255, 0, 0);
    rect(600, buttonY, 100, 50); //angry button
    fill(0);
    text(emotionChoices.get(currentPhoto).get(2), 600+20, textY); //option 3: angry
    
    //draw a blank face
    drawBlankFace();
    
    //choose an emotion to display
    //fix:
    if (keepGenerating == true){
      question = setupPhotos();
    }
    
    //display the chosen emotion
    println("question: " + question);
    switch(question){
      case 1:
        addHappyFeatures();
      case 2:
        addSadFeatures();
      case 3:
        addAngryFeatures();
    }
  }
  
  int setupPhotos() {
    keepGenerating = false;
    return int(random(1, 3));
  }
  
  void setupEmotions() {
    emotions.add("happy");
    ArrayList<String> temp = new ArrayList<String>();
    temp.add("happy");
    temp.add("sad");
    temp.add("angry");
    emotionChoices.add(temp);
  }
  
  void checkInput() {
    if (int(inputs.get("yellow button")) == 1) {
      answerChosen = emotionChoices.get(currentPhoto).get(0);
    } else if (int(inputs.get("blue button")) == 1) {
      answerChosen = emotionChoices.get(currentPhoto).get(1);
    } else if (int(inputs.get("red button")) == 1) {
      answerChosen = emotionChoices.get(currentPhoto).get(2);
    }
    /*
    if (answerChosen != "") {
      if(answerChosen == emotions.get(currentPhoto)) {        
        questionCompleted(true, "emote");
        keepGenerating = true;
      } else {
        questionCompleted(false, "emote");
      }
    }
    */
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

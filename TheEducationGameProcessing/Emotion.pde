class Emotion {
  ArrayList<PImage> photos = new ArrayList<PImage>();
  ArrayList<String> emotions = new ArrayList<String>();
  ArrayList<ArrayList<String>> emotionChoices = new ArrayList<ArrayList<String>>();
  int currentPhoto = 0;
  String answerChosen = "";
  
  Emotion() {
    setupPhotos();
    setupEmotions();
  }
  
  void drawMe() {
    background(255);
    fill(0, 0, 0);
    fill(255, 255, 0);
    rect(100, 300, 100, 50);
    textSize(25);
    fill(0);
    text(emotionChoices.get(currentPhoto).get(0), 100+20, 335);
    fill(0, 0, 255);
    rect(350, 300, 100, 50);
    fill(255);
    text(emotionChoices.get(currentPhoto).get(1), 350+20, 335);
    fill(255, 0, 0);
    rect(600, 300, 100, 50);
    fill(0);
    text(emotionChoices.get(currentPhoto).get(2), 600+20, 335);
  }
  
  void setupPhotos() {
  }
  
  void setupEmotions() {
    //Adding the right emotion
    emotions.add("happy");
    //Adding a multiple choice of emotions that will appear on screen
    ArrayList<String> temp = new ArrayList<String>();
    temp.add("happy");
    temp.add("sad");
    temp.add("angry");
    emotionChoices.add(temp);
  }
  
  void checkInput() {
    //Checks if the button pressed is the right one and then does the normal if right, then true. if wrong, then false stuff
    if (int(inputs.get("yellow button")) == 1) {
      answerChosen = emotionChoices.get(currentPhoto).get(0);
    } else if (int(inputs.get("blue button")) == 1) {
      answerChosen = emotionChoices.get(currentPhoto).get(1);
    } else if (int(inputs.get("red button")) == 1) {
      answerChosen = emotionChoices.get(currentPhoto).get(2);
    }
    if (answerChosen != "") {
      if(answerChosen == emotions.get(currentPhoto)) {
        questionCompleted(true, "emote");
      } else {
        questionCompleted(false, "emote");
      }
    }
  }
}

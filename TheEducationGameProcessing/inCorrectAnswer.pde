class inCorrectAnswer {
  String previousScene;
  
  void drawMe() {
    background(255, 0, 0);
    fill(0);
    textSize(72);
    text("Aww!", width/3, height/2);
    textSize(32);
    text("You didn't get it right!", width/3, height*2/3);
  }
  
  void checkInput() {
  }
}

class inCorrectAnswer {
  String previousScene;
  
  void drawMe() {
    background(255, 0, 0);
    fill(0);
    textSize(150);
    text("Aww!", width/3 - 50, height/2 - 25);//w/3
    textSize(42);
    text("You didn't get it right!", width/3 - 40, height/2 + 75);
  }
  
  void checkInput() {
  }
}

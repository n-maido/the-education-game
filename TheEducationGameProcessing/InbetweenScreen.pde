class InbetweenScreen {
  void drawMe() {
    fill(0, 0, 0);
    textSize(32);
    text("Hello", 200, 200);
    fill(255, 255, 0);
    rect(100, 300, 100, 50);
    fill(0);
    text("1", 142.5, 335);
    fill(0, 0, 255);
    rect(350, 300, 100, 50);
    fill(0);
    text("2", 392.5, 335);
    fill(255, 0, 0);
    rect(600, 300, 100, 50);
    fill(0);
    text("3", 642.5, 335);
  }
  
  int checkInput() {
    if (mouseX <= 200 && mouseX >= 100 && mouseY <= 350 && mouseY >= 300) {
      return 1;
    } else if (mouseX <= 450 && mouseX >= 350 && mouseY <= 350 && mouseY >= 300) {
      return 2;
    } else if (mouseX <= 700 && mouseX >= 600 && mouseY <= 350 && mouseY >= 300) {
      return 3;
    } else {
      return -1;
    }
  }
}

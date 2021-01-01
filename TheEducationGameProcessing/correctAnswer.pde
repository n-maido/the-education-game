/*
 * CorrectAnswer.pde
 *
 * Description: Displays a green screen congratulating the user, after a question has been answered correctly
 *
 * Authors: Steven Kobza
 *
*/
class CorrectAnswer {
  
  void drawMe() {
    background(0, 255, 0);
    fill(0);
    textSize(150);
    text("Yay!", width/3, height/2 - 25);
    textSize(42);
    text("You got it right!", width/3 + 10, height/2 + 80);
    
  }
}

class Background{
  final PVector bgPos = new PVector();
  final PVector bgVel = new PVector();
  final static float backgroundVel = 1;
  
  void displayBG(){
    bgPos.add(bgVel);
    image(bg, bgPos.x, bgPos.y);
  }
  
  void displayLevel(){
    textFont(fontBold);
    fill(120);
    text("Beta Version 0.2", width-133, height-10);
  }
  
  void displayBloodSign(){
    int bloodWidth = 15;
    int bloodHeight = 20;
    image(rocket, 10, height-30, bloodWidth, bloodHeight);
  }
  
  void displayLogo(){
    image(logo, 55,100);
    textFont(fontBold);
    fill(170);
    text("Press space button to start", 200, 450);
  }
  
  void displayGameOver(){
    image(game_over, 55,100);
    textFont(fontBold);
    fill(170);
    text("Press space button to start", 200, 450);
    
    //score
    textFont(fontBold);
    fill(150);
    text("Your Score :", width/2-50, 500);
    fill(255);   
    text(plane.score, (width/2)+50, 500);
  }
  
}
class Lives{
  public PVector livesPos = new PVector();
  int livesWidth = 15;
  int livesHeight = 20;
  boolean remove;
  
  Lives(float x, float y){
    livesPos.set(x,y);
  }
  
  void updateLives(){
   // if()   
  }
  
  void createLives(){
    image(rocket, livesPos.x, livesPos.y, livesWidth, livesHeight);   
  }
  
}
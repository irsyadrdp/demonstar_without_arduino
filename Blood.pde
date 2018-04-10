class Blood{
  public PVector bloodPos = new PVector();
  int bloodWidth = 15;
  int bloodHeight = 15;
  boolean remove;
  
  
  Blood(float x, float y){
    bloodPos.set(x,y);
  }
  
  void updateBlood(){
   // if()   
  }
  
  void createBlood(){
    fill(200,0,0);
    rectMode(CENTER);
    rect(bloodPos.x, bloodPos.y, bloodWidth, bloodHeight);
  }
  
}
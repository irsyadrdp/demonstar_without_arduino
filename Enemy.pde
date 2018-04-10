//Enemy class
class Enemy{
  PVector enemyPos = new PVector();
  PVector enemyVel = new PVector();
  int enemySize;
  int enemyType;
  boolean remove;
  
  Enemy(float x, float y, PVector enemyVel, int enemySize, int enemyType){
    enemyPos.set(x,y);
    this.enemyVel = enemyVel;
    this.enemySize = enemySize;
    this.enemyType = enemyType;
  }
 
  void updateEnemy(){
    enemyPos.add(enemyVel);
    if(enemyPos.x < -enemySize || enemyPos.x > width+enemySize || 
       enemyPos.y < -enemySize || enemyPos.y > height+enemySize ||
       beenShot()){
          enemies.remove(this);
          plane.score+=10;
          image(explosion,enemyPos.x, enemyPos.y, 100,100);
          for(int i=0 ; i<1000000 ;i++) explosion.play();
    }
    
    if(planeBeenHit()){
      bloodBlocks-=0.1;
      println(bloodBlocks);
      if(bloodBlocks<-1){
        livesAmount--;
        bloodBlocks=10;
        
        //game over
        if(livesAmount==-1) gameState=2;
      }
    }
  }
  
  void createEnemy(){
    /*
    noStroke();
    fill(150);
    ellipse(enemyPos.x, enemyPos.y, enemySize, enemySize);
    */
    
    //load satellite image
    if(enemyType==1) image(satellite1, enemyPos.x, enemyPos.y, enemySize, enemySize);
    else if(enemyType==2) image(satellite2, enemyPos.x, enemyPos.y, enemySize, enemySize);
    else if(enemyType==3) image(satellite3, enemyPos.x, enemyPos.y, enemySize, enemySize);
    else if(enemyType==4) image(satellite4, enemyPos.x, enemyPos.y, enemySize, enemySize);
    else if(enemyType==5) image(satellite5, enemyPos.x, enemyPos.y, enemySize, enemySize);
    
  }
 
  boolean beenShot(){
    for (Bullet b : bullets){
      if(enemyPos.dist(b.bulletPos) < enemySize){
        return true;
      }  
    }
    return false;
  }
  
  boolean planeBeenHit(){
    if(enemyPos.dist(plane.planePos) < enemySize){
      return true;
    }
    return false;
   }
  
}//end of Enemy class
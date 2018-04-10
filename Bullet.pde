//Bullet class
class Bullet extends PVector{
  
  public PVector bulletPos = new PVector(); //bullet position
  PVector vel;  //velocity
  public boolean remove;
  
  Bullet(PVector loc, PVector vel){
    super(loc.x, loc.y);
    this.vel = vel;
  }
  
  void createBullet(){
    final byte bulletSize = 4;
    fill(255);
    rect(x, y, bulletSize, bulletSize);
  }
  
  boolean updateBullet(){
    add(vel);
    bulletPos.set(x,y);
    return x>width || x<0 || y>height || y<0; 
  }
  
  boolean run(){
    createBullet();
    return updateBullet();
  }
  
}//end of Bullet class
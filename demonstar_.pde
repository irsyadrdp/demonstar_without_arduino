
////////////////////////////////MAIN FUNCTION////////////////////////////

//import
import gifAnimation.*;

//open class
ArrayList<Bullet> bullets = new ArrayList();               //bullet
Plane plane = new Plane();                                 //plane 
Background background = new Background();                  //background
ArrayList<Enemy> enemies = new ArrayList();                //enemy
ArrayList<Lives> lives = new ArrayList();                  //lives
ArrayList<Blood> blood = new ArrayList();                  //blood
 
//load images dan GIF
PImage bg, logo, game_over;
PImage rocket;
PImage satellite1, satellite2, satellite3, satellite4, satellite5;
Gif explosion;

//lives, blood
int livesGap = 10;             //initial x position of lives
int livesAmount = 3;           //default amount of lives is 3
float bloodBlocks = 10;        //default amount of blood block is 10
int initialBloodPos = 35;      //initial x position of blood block

//text
PFont fontBold;

//background height
float bg_height=-2400;

//key code for keyboard button
boolean buttons[]=new boolean[255];

//gameState, that indicates opening, main gameplay, and gameover
int gameState=0;

void setup() {
  size(600, 600);
  smooth();
  noStroke();
  cursor(CROSS);
  frameRate(60);
  
  //background and plane
  rocket = loadImage("assets/rocket.png");
  bg = loadImage("assets/background.jpg");
  satellite1 = loadImage("assets/satellite_1.png");
  satellite2 = loadImage("assets/satellite_2.png");
  satellite3 = loadImage("assets/satellite_3.png");
  satellite4 = loadImage("assets/satellite_4.png");
  satellite5 = loadImage("assets/satellite_5.png");
  logo = loadImage("assets/logo.png");
  game_over = loadImage("assets/game_over.png");
  
  //explosion
  explosion = new Gif(this, "assets/explosion.GIF");
  explosion.play();
  //explosion.ignoreRepeat();

  //set origin position of: plane, background
  plane.planePos.set(width>>1, (height>>1)+200, 0);
  background.bgPos.set(0, bg_height, 0);
  
  //lives
  for(int i=0 ; i<livesAmount ; i++) {
    lives.add(new Lives(livesGap, 28));
    livesGap+=18;
  }
  
  //blood
  for(int i=0 ; i<bloodBlocks ; i++){  
    blood.add(new Blood(initialBloodPos,height-20));
    initialBloodPos+=12;
  }
  
  //text object
  textSize(15);
  textAlign(LEFT);
  fontBold = createFont("Arial Bold", 15);
  
}////end of setup function

void draw() {
  focused = true;
  if(gameState==0){        //opening
    //background
        background.displayBG();
        background.displayLogo();
        shoot();
  }
  else if(gameState==1){   //main gameplay
    //background
        background.displayBG();
        background.displayLevel();
        background.displayBloodSign();
        background.bgVel.y = +background.backgroundVel;
        bg_height +=1;
        if (bg_height == 0){ bg_height=-2400; background.bgPos.set(0, -2400, 0); }
  
    //enemy
        for(int i=enemies.size()-1 ; i>=0 ; i--){
          Enemy e = enemies.get(i);
          e.updateEnemy();
          e.createEnemy();
        }
        addEnemy(30);
    
    //Lives
        //for(int i=lives.size()-1 ; i>=0 ; i--){
        for(int i=0 ; i<livesAmount ; i++){  
          Lives l = lives.get(i);
          l.updateLives();
          l.createLives();
        }
    //blood
        //for(int i=blood.size()-1 ; i>=0 ; i--){
        for(int i=0 ; i<bloodBlocks ; i++){
          Blood b = blood.get(i);
          b.updateBlood();
          b.createBlood();
        }  
    
    //player
        plane.screenBound();
        plane.createPlane();
        plane.shoot();
        shoot();
    
    //text
        fill(200,0,0);
        text("Player 1", 10, 20);   
  }    
  else if(gameState==2){   //game over
    //background
        background.displayBG();
        background.displayGameOver();
        shoot();
  } 
}////end of draw function

void keyPressed() {
  final int button = keyCode;
  if (button == LEFT)       plane.planeSpeed.x = -plane.planeVel;
  else if (button == RIGHT) plane.planeSpeed.x = plane.planeVel;
  else if (button == UP)    plane.planeSpeed.y = -plane.planeVel;
  else if (button == DOWN)  plane.planeSpeed.y = plane.planeVel;
  
  buttons[keyCode]=true;
}
void keyReleased() {
  final int button = keyCode;
  if ( button == LEFT && plane.planeSpeed.x < 0 || 
       button == RIGHT && plane.planeSpeed.x > 0 ){ plane.planeSpeed.x = 0; }
  else if ( button == UP && plane.planeSpeed.y < 0 || 
       button == DOWN && plane.planeSpeed.y > 0){ plane.planeSpeed.y = 0; }

  buttons[keyCode]=false;
}

void shoot() {
  //for (Bullet b: bullets)  b.run(); //unremovable bullets!
  for ( int b = bullets.size(); b != 0; ){
    if ( bullets.get(--b).run() )  bullets.remove(b);
  }
  //print(bullets.get(--b) + "\t");
  
  //handle fire button on keyboard
  final int bulletDens = 3;     //bullet density                                             
  if((buttons[17] || buttons[32]) && frameCount % bulletDens == 0) plane.addBullet();
  
  if(gameState==0 || gameState==2){
    if(buttons[17] || buttons[32]) gameState=1;
  }
}

void addEnemy(int eAmount){
  if(frameCount % eAmount == 0){
    int enemeSize=80;
    enemies.add(new Enemy(random(width-enemeSize), -50, new PVector(0,3), enemeSize, (int)random(1,6)));
  }
}

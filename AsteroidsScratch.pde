/***	Asteroids Game redo/scratch board	***/

/***
  TO DO:
  - modes ie 0 = gameStart(); 1 = gameOver()
  - flow 
***/

final int SIZE = 750;

SpaceShip shuttle;

ArrayList <Bullet> bullets = new ArrayList <Bullet>();
int numBullets = 0;

public int NUM_STARS = 100;
Stars[] space = new Stars[NUM_STARS];

public int NUM_ASTEROIDS = 30;
ArrayList <Asteroid> asteroids = new ArrayList <Asteroid>();

public boolean lose = false;
public int score = 0;

public void setup() 
{
  size(750, 750); // use ints for Processing
  
  /**/
  if (lose == true)
  {
    loseScreen();
  }
  else
  {
    startScreen();
    // background(125);
    // textSize(25);
    // text("Press ENTER to Play", SIZE/2-110, SIZE/2);
    /**/

    for (int i = 0; i < space.length; i++)
    {
      space[i] = new Stars();
    }

    for (int i = 0; i < NUM_ASTEROIDS; i++)
    {
      asteroids.add(new Asteroid());
    }

    shuttle = new SpaceShip();
    shuttle.setPointDirection(270);    
  }

}
public void draw() 
{
  /**/if (key == ENTER)
  {  /**/
    background(0);
  
      for (int i = 0; i < space.length; i++)
      {
        space[i].show();
      }
  
      shuttle.show();
      shuttle.move();

      for (int i = 0; i < asteroids.size(); i++)
      {
        asteroids.get(i).show();
        asteroids.get(i).move();
        // if shuttle hits asteroids
        if(dist(shuttle.getX(), shuttle.getY(), asteroids.get(i).getX(), asteroids.get(i).getY()) < 20)
        {
          lose = true;
          setup();
          // noLoop();
          // fill(125);
          // rect(0, 0, SIZE, SIZE);
          // textSize(25);
          // stroke(255);
          // text("Game Over", 400, SIZE/2);
        }
      }

      for (int i = 0; i < bullets.size(); i++)
      {
        bullets.get(i).show();
        bullets.get(i).move();
        for (int j = 0; j < asteroids.size(); j++)
        {
          if(dist(bullets.get(i).getX(), bullets.get(i).getY(), asteroids.get(j).getX(), asteroids.get(j).getY())<20)
          {
            // System.out.println("Bullet hit Asteroid.");
            asteroids.remove(j);
            bullets.remove(i);
            score++;
            break; // breaks out of loop to recheck ArrayList.size() in loop i
          }
        }
      }

      textSize(13);
      stroke(255);
      text("Score: " + score, 10, 50);
      text("Num Asteroids: " + asteroids.size(), 10, 725);
      text("Num Bullets: " + bullets.size(), 10, 740);

  }
}

public void keyPressed()
{
  if (key == 'w')
  {
    shuttle.accelerate(0.3); // moves forward
  }
  else if (key == 'a')
  {
    shuttle.turn(-20); // left rotate
  }
  else if (key == 'd')
  {
    shuttle.turn(25); // right rotate
  }
  /*else if (key == 's')
  {
    shuttle.accelerate(-0.3); // move backwards
  }*/
  else if (key == 32) //32 = space
  {
    shuttle.setX((int)((Math.random()*400)+100));
    shuttle.setY((int)((Math.random()*400)+100));
    shuttle.setDirectionX(0);
    shuttle.setDirectionY(0);
  }
  else if (key == 'f')
  {
    bullets.add(new Bullet(shuttle));
  }
  /*
  else
  {
    System.out.println("other key");
  }*/

  /*if(key == 'n')
  {
    NUM_ASTEROIDS = 30;
    setup();
  }
  */
}

class SpaceShip extends Floater  
{   
  public SpaceShip() 
  {
    corners = 4;
    int[] xS = {-8, 16, -8, -2};
    int[] yS = {-8, 0, 8, 0};
    xCorners = xS;
    yCorners = yS;
    myColor = 255;
    myCenterX = SIZE/2;
    myCenterY = SIZE/2;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x) { myCenterX = x; } 
  public int getX() { return (int)myCenterX; }   
  public void setY(int y) { myCenterY = y; }   
  public int getY() { return (int)myCenterY; }
  public void setDirectionX(double x) { myDirectionX = x; }   
  public double getDirectionX() { return myDirectionX; }  
  public void setDirectionY(double y) { myDirectionY = y; }   
  public double getDirectionY() { return myDirectionY; }  
  public void setPointDirection(int degrees) { myPointDirection = degrees; }   
  public double getPointDirection() { return myPointDirection; }
}

class Bullet extends Floater
{
  Bullet(SpaceShip theShip)
  {
    // myColor = 125;
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    double dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5*Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY = 5*Math.sin(dRadians) + theShip.getDirectionY();
  }
  public void show()
  {
    noStroke();
    fill(0, 255, 0);
    ellipse((float)myCenterX, (float)myCenterY, 5, 5);    
  }
  public void setX(int x) { myCenterX = x; } 
  public int getX() { return (int)myCenterX; }   
  public void setY(int y) { myCenterY = y; }   
  public int getY() { return (int)myCenterY; }
  public void setDirectionX(double x) { myDirectionX = x; }   
  public double getDirectionX() { return myDirectionX; }  
  public void setDirectionY(double y) { myDirectionY = y; }   
  public double getDirectionY() { return myDirectionY; }  
  public void setPointDirection(int degrees) { myPointDirection = degrees; }   
  public double getPointDirection() { return myPointDirection; }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void turn (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  // Draws the floater at the current position  
  {             
    fill(myColor); 
    strokeWeight(1);  
    stroke(myColor); 

    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

class Asteroid extends Floater
{
  private int speedOfRotation;
  public Asteroid() 
  {
    corners = 6;
    int[] xA = {-8, 4, 13, 16, 4, -10};
    int[] yA = {10, 12, 6, -5, -10, -4};
    xCorners = xA;
    yCorners = yA;
    myColor = 125;
    myCenterX = Math.random()*SIZE;
    myCenterY = Math.random()*SIZE;
    myDirectionX = (Math.random()*5)-2;
    myDirectionY = (Math.random()*5)-2;
    myPointDirection = 0;  
    speedOfRotation = (int)((Math.random()*3)+1);  
  }
  public void move()
  {
    turn(speedOfRotation);
    super.move();   
  }
  public void setX(int x) { myCenterX = x; } 
  public int getX() { return (int)myCenterX; }   
  public void setY(int y) { myCenterY = y; }   
  public int getY() { return (int)myCenterY; }
  public void setDirectionX(double x) { myDirectionX = x; }   
  public double getDirectionX() { return myDirectionX; }  
  public void setDirectionY(double y) { myDirectionY = y; }   
  public double getDirectionY() { return myDirectionY; }  
  public void setPointDirection(int degrees) { myPointDirection = degrees; }   
  public double getPointDirection() { return myPointDirection; }
}

class Stars
{
  double starX, starY;
  public Stars()
  {
    starX = Math.random()*SIZE;
    starY = Math.random()*SIZE;
  }
  public void show()
  {
    fill(255);
    strokeWeight(0.25);
    stroke(255, 0, 0);
    ellipse((float)starX, (float)starY, 3, 3);
  }
}

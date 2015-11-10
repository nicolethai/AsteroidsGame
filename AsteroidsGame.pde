//your variable declarations here
final int SIZE = 750;

SpaceShip shuttle;

final int NUM_STARS = 50;
Stars[] space = new Stars[NUM_STARS];

public void setup() 
{
  size(SIZE, SIZE);

  for (int i = 0; i < space.length; i++)
  {
    space[i] = new Stars();
  }

  shuttle = new SpaceShip();
  shuttle.setPointDirection(270);

}
public void draw() 
{
  background(0);
  shuttle.show();
  shuttle.move();

  for (int i = 0; i < space.length; i++)
  {
    space[i].show();
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
    shuttle.rotate(-20); // left rotate
  }
  else if (key == 'd')
  {
    shuttle.rotate(25); // right rotate
  }
  /*else if (key == 's')
  {
    shuttle.accelerate(-0.3); // move backwards
  }*/
  else if (key == 32)
  {
    shuttle.setX((int)((Math.random()*400)+100));
    shuttle.setY((int)((Math.random()*400)+100));
    shuttle.setDirectionX(0);
    shuttle.setDirectionY(0);
  }
  else
  {
    System.out.println("other key");

  }
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
  public int getY() { return (int)myCenterX; }
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
  public void rotate (int nDegreesOfRotation)   
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
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
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
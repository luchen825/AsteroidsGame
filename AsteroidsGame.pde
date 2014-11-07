SpaceShip one;
Stars [] two;
Asteroid [] three;
public void setup() 
{
  size(600,500);
  background(0);
  one = new SpaceShip();
  two = new Stars[150];
  for(int i=0; i < two.length; i++)
  {
    two[i] = new Stars((int)(Math.random()*600),(int)(Math.random()*500));
  }
  three = new Asteroid[10];
  for(int j=0; j < three.length; j++)
  {
    three[j] = new Asteroid((int)(Math.random()*10)-5);
    three[j].setDirectionX(Math.random()*2-1);
    three[j].setDirectionY(Math.random()*2-1);
  }
}
public void draw() 
{
  background(0);
  for(int i=0; i < two.length; i++)
  {
    two[i].show();
  }
  for(int j=0; j < three.length; j++)
  {
    three[j].move();
    three[j].show();
  }
  one.move();
  one.show();
}
class SpaceShip extends Floater  
{   

  public SpaceShip()
  {
    corners = 4;
    xCorners = new int[corners];
    xCorners[0] = -10;
    xCorners[1] = 16;
    xCorners[2] = -10;
    xCorners[3] = -4;
    yCorners = new int[corners];
    yCorners[0] = -10;
    yCorners[1] = 0;
    yCorners[2] = 10;
    yCorners[3] = 0;
    myColor = 255;
    myCenterX = 300;
    myCenterY = 250;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}
}
class Asteroid extends Floater
{
  private int rSpeed;
  Asteroid(int rotspeed)
  {
    rSpeed = rotspeed;
    corners = 5;
    xCorners = new int [corners];
    xCorners[0] = -9;
    xCorners[1] = 0;
    xCorners[2] = 4;
    xCorners[3] = 0;
    xCorners[4] = -11;
    yCorners = new int [corners];
    yCorners[0] = 5;
    yCorners[1] = 7;
    yCorners[2] = 0;
    yCorners[3] = -5;
    yCorners[4] = -2;
    myColor = 200;
    myCenterX = (int)(Math.random()*500) + 50;
    myCenterY = (int)(Math.random()*400) + 50;
  }
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}
  public void move()
  {
    rotate(rSpeed);
    super.move();
  }
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
class Stars extends Floater
{
  Stars(double a, double b)
  {
    corners = 10;
    xCorners = new int[corners];
    xCorners[0] = -1;
    xCorners[1] = 2;
    xCorners[2] = 2;
    xCorners[3] = 4;
    xCorners[4] = 7;
    xCorners[5] = 5;
    xCorners[6] = 7;
    xCorners[7] = 4;
    xCorners[8] = 2;
    xCorners[9] = 2;
    yCorners = new int[corners];
    yCorners[0] = 0;
    yCorners[1] = 1;
    yCorners[2] = 5;
    yCorners[3] = 2;
    yCorners[4] = 3;
    yCorners[5] = 0;
    yCorners[6] = -3;
    yCorners[7] = -2;
    yCorners[8] = -5;
    yCorners[9] = -1;
    myColor = 125;
    myCenterX = a;
    myCenterY = b;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}
}
public void keyPressed()
{
  if(key == 'h')
  {
    one.setX((int)(Math.random()*500) + 50);
    one.setY((int)(Math.random()*400) + 50);
    one.setPointDirection((int)(Math.random()*360));
    one.setDirectionX(0);
    one.setDirectionY(0);
  }
  if(key == 'a')
  {
    one.accelerate(Math.random());
  }
  if(key == 'd')
  {
    one.accelerate(-Math.random());
  }
  if(key == 'w')
  {
    one.rotate(-15);
  }
  if(key == 's') 
  {
    one.rotate(15);
  }
}

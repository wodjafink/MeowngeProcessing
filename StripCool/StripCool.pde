float x;
float y;
float angle;
float deltaAngle;

int startTime = 0;
OPC opc;
MEOWNGE meownge;
PImage dot;
color theColor;

int currTime, nextTime;
final int INTERVAL = 500;
 
int c = 0;

void setup() {
  size(800, 600, P3D);
  background(0);
  //smooth();
  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);
  
  nextTime = millis() + INTERVAL;

}

void draw() {
  meownge.update();
  meownge.show();
}

void myDelay(int ms)
{
   try
  {   
    Thread.sleep(ms);
  }
  catch(Exception e){}
}
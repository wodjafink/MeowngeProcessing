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
  //int now = millis();
  //int stripIndex = 0;

  //if (millis() > (startTime + 1000))
  //{
  //  startTime = millis();
  //  stripIndex = (int)now % 46;
  //  meownge.setStripColor(stripIndex, (int)random(255), 0 , 0);

  //}
  //    background(0);
      
  //background(0);
  if(millis() >= nextTime){
    println(millis()); // Print actual time for debug
    // Now put the time dependant code here
      //meownge.setStripColor(c - 1, 0, 0, 0);
    meownge.setStripColor(c++, 255, 0 , 0);
    // Update the time for the next time
    nextTime += INTERVAL;

  }

  //text(c, 70, 140);
}

void myDelay(int ms)
{
   try
  {   
    Thread.sleep(ms);
  }
  catch(Exception e){}
}
float x;
float y;
float angle;
float deltaAngle;
color c;

OPC opc;
MEOWNGE meownge;
PImage dot;
color theColor;

void setup() {
  size(800, 600, P3D);
  background(255);
  smooth();
  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);

}

void draw() {
  background(0);

  for (int i = 0; i < 46; i++)
  {
     meownge.setStripColor(i, 255 , 0 , 0);
     delay(100);
  }

}
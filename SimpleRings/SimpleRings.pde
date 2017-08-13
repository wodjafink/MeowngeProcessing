import java.io.*;

OPC opc;
MEOWNGE meownge;
PImage dot;
Ring r1, r2;
color theColor;

void setup()
{
  size(600, 600);

  r1 = new Ring();
  r2 = new Ring();
  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);
  r1.start(300, 300);
  r2.start(300, 300);
  
  theColor = color(random(255),random(255),random(255));
}

void draw()
{
  background(0);
  
  if (r1.diameter > height)
  {
      r2.setDiameter(0);
      r1.grow();
      r1.display();
  }
  else
  {
      r1.setDiameter(0);
      r2.grow();
      r2.display();
  }
}

class Ring {
  
  float x, y; // X-coordinate, y-coordinate
  float diameter; // Diameter of the ring
  boolean on = false; // Turns the display on and off
  
  void start(float xpos, float ypos) {
    x = xpos;
    y = ypos;
    on = true;
    diameter = 1;
  }
  
  void grow() {
    if (on == true) {
      diameter += 1;
      if (diameter > width*2) {
        diameter = 0.0;
      }
    }
  }
  
  void display() {
    if (on == true) {

      fill(theColor);
      stroke(255, 0, 50, 150);
      strokeWeight(10);
      ellipse(x, y, diameter - 20, diameter - 20);
      stroke(50, 0, 255, 150);
      strokeWeight(5);
      ellipse(x, y, diameter, diameter);
    }
  }
  void setDiameter(int newD)
  {
    diameter = newD;
  }
}

//Useful, and obvious!
void mousePressed() {
   background(0);
   exit();
}
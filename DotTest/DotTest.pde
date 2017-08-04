import java.io.*;

OPC opc;
MEOWNGE meownge;
PImage dot;


void setup()
{
  size(600, 600);

  // Load a sample image
  dot = loadImage("dot.png");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);

}

void draw()
{
  background(0);
  
  // Change the dot size as a function of time, to make it "throb"
  float dotSize = height * 0.1 * (1.0 + 0.2 * sin(millis() * 0.01));
  
  // Draw it centered at the mouse location
  image(dot, mouseX - dotSize/2, mouseY - dotSize/2, dotSize, dotSize);
}
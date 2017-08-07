import java.io.*;

OPC opc;
MEOWNGE meownge;
Star[] stars = new Star[400];

void setup() {
  size (600, 600);
    // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);
  
  for (int i = 0; i < stars.length; i++)
  {
    stars[i] = new Star(); 
  }
}

void draw() {
  background(0);
  translate(width / 2, height / 2);
  for (int i = 0; i < stars.length; i++) 
  {
     stars[i].update();
     stars[i].show();
  }
}

  
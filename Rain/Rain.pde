import java.io.*;

OPC opc;
MEOWNGE meownge;
Drop[] drops = new Drop[500];

void setup() {
  size (600, 600);
    // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);
  for (int i = 0; i < drops.length; i++)
  {
    drops[i] = new Drop();
  }
}

void draw() {
  background(0);
  for (int i = 0; i < drops.length; i++)
  {
     drops[i].show();
     drops[i].fall();
  }
  
  meownge.NoseUpdate();
  meownge.NoseShow();

}

void mousePressed(){
   background(0);
   exit();
}
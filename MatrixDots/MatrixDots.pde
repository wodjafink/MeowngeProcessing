import java.io.*;
float a = 30;
OPC opc;
MEOWNGE meownge;

void setup() {
  size (600, 600);
    // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);
  
    noStroke();
  fill(0, 255, 150);

}

void draw() {
  background(40);
  translate(width/2-25, height/2);
  for (int i = 0; i < 360; i+=a) {
    for(int q = -36; q < 36; q++){
      float x = i/(a/6)+tan(radians(dist(i/(a/2), i/(a/2), 0, 0)+q*50+frameCount))*a;
      ellipse(x, q*10, 5, 5); 
    }
  }
}

void mousePressed(){
   background(0);
   exit();
}
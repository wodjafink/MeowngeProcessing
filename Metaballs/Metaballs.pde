import java.io.*;

OPC opc;
MEOWNGE meownge;
Blob[] blobs = new Blob[15];

void setup()
{
  size(600, 600);
  colorMode(HSB);
  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);
  
  for (int i = 0; i < blobs.length; i++)
  {
    blobs[i] = new Blob(random(width), random(height)); 
  }
}

void draw()
{
  background(0);
  
  loadPixels();
  for (int x = 0; x < width; x++)
  {
     for (int y = 0; y < width; y++)
     {
        int index = x + y * width;
        float sum = 0;
        for (Blob b : blobs)
        {
          float d = dist(x, y, b.pos.x, b.pos.y);
          sum += 10 * b.r / d;
        }
        pixels[index] = color(sum % 255, 255, 255);
     }
  }
  
  updatePixels();
  
  for (Blob b : blobs)
  {
    b.update();
    //b.show();
  }
  

}

void mousePressed()
{
  background(0);
  exit();
}
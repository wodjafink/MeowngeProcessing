import java.io.*;

OPC opc;
MEOWNGE meownge;
PImage im;


void setup()
{
  size(600, 600);

  File f = new File("/Users/jaredmednick/fadecandy/examples/processing/strip64_flames/data");
  int count = 0;
  for (File file : f.listFiles()){
     if (file.isFile() &&
       (file.getName().endsWith(".jpg") || file.getName().endsWith(".jpeg")))
       count++;
  }

  println("Found " + count + " images");

  // Load a sample image
  im = loadImage("rainbowspiral.jpg");

  
   //imageMode(CENTER);

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);

}

//Scroll Vertical
//void draw()
//{
//  // Scale the image so that it matches the width of the window
//  int imHeight = im.height * width / im.width;

//  // Scroll down slowly, and wrap around
//  float speed = 0.05;
//  float y = (millis() * -speed) % imHeight;
  
//  // Use two copies of the image, so it seems to repeat infinitely  
//  image(im, 0, y, width, imHeight);
//  image(im, 0, y + imHeight, width, imHeight);
//}

//Scroll Horizontal
void draw()
{
   int imWidth = im.width * height / im.height;
   
   float speed = 0.05;
   float x = (millis() * -speed) % imWidth;
   
   image(im, x, 0, imWidth, height);
   image(im, x + imWidth, 0, imWidth, height);
}

//Rotate!
//void draw()
//{
  
//  image(im, width/2 - im.width/2, height - im.height/4);

//  translate(width/2, height/2);
//  rotate(HALF_PI * millis() * 0.001);
//  image(im, 0, 0);

//}

//Useful, and obvious!
void mousePressed() {
   background(0);
   exit();
}
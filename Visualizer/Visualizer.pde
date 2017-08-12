// Some real-time FFT! This visualizes music in the frequency domain using a
// polar-coordinate particle system. Particle size and radial distance are modulated
// using a filtered FFT. Color is sampled from an image.

import ddf.minim.analysis.*;
import ddf.minim.*;

OPC opc;
MEOWNGE meownge;

PImage dot;
PImage colors;
Minim minim;
AudioInput in;
FFT fft;
float[] fftFilter;

float spin = 0.004;
float radiansPerBucket = radians(4);
float decay = 0.9;
float opacity = 20;
float minSize = 0.2;
float sizeScale = 0.1;

void setup()
{
  size(600, 600, P3D);

  minim = new Minim(this); 

  // Small buffer size!
  in = minim.getLineIn();

  fft = new FFT(in.bufferSize(), in.sampleRate());
  fftFilter = new float[fft.specSize()];

  dot = loadImage("dot.png");
  colors = loadImage("colors.png");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);

}

void draw()
{
  background(0);

  meownge.update();
  meownge.show();
}
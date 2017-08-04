int pal []=new int [128];
int[] cls;
OPC opc;
MEOWNGE meownge;
void setup(){
  size(600, 600);
  float s1,s2;
  for (int i=0;i<128;i++) {
    s1=sin(i*PI/25);
    s2=sin(i*PI/50-PI/4);
    pal[i]=color(32+s1*128,32+s2*128,s1*128);
    //pal[i]=color(random(255)+s1,random(255)+s2,random(255)*s1);
  }

  cls = new int[width*height];
  for (int x = 0; x < width; x++)
  {
    for (int y = 0; y < height; y++)
    {
      cls[x+y*width] = (int)((127.5 + +(127.5 * sin(x / 32.0)))+ (127.5 + +(127.5 * cos(y / 32.0))) + (127.5 + +(127.5 * sin(sqrt((x * x + y * y)) / 32.0)))  ) / 4;
    }
  }
  
    // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);
}

void draw()
{
  loadPixels();
  for (int pixelCount = 0; pixelCount < cls.length; pixelCount++)
  {                    
    pixels[pixelCount] =  pal[(cls[pixelCount] + frameCount)&127];
  }
  updatePixels();  
}
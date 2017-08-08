OPC opc;
MEOWNGE meownge;
PImage e;

void setup()
{
  size(600, 600);

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);
  
  e = getElectronImg(30,30,(int)random(255),100,100);

}

void draw()
{
  background(0);
 
  translate(width * .5, height * .5);
  for(int i = 0 ; i < 500 ; i++){
    float a = (frameCount * .025 + (i*.1));
    image(e,(100+(i * .75))*cos(a + i), (50+(i * .75))*sin(a + i));
  }
}

PImage getElectronImg(int w,int h,int hue,int satMax,int brightness){
  pushStyle();//isolate drawing styles such as color Mode
    colorMode(HSB,360,100,100);
    PImage electron = createImage(w,h,ARGB);//create an image with an alpha channel
    int np = w * h;//total number of pixels
    int cx = electron.width/2;//center on x
    int cy = electron.height/2;//center on y
    for(int i = 0 ; i < np; i++){//for each pixel
      int x = i%electron.width;//compute x from pixel index
      int y = (int)(i/electron.width);//compute y from pixel index
      float d = dist(x,y,cx,cy);//compute distance from centre to current pixel
      electron.pixels[i] = color(hue,map(d,0,cx,satMax,0),brightness,map(d,0,cx,255,0));//map the saturation and transparency based on the distance to centre
    }
    electron.updatePixels();//finally update all the pixels
  popStyle();
  return electron;
}
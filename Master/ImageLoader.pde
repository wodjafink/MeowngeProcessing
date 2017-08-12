PImage im;

class ImageLoader extends DefaultDrawer
{
  int alphaVal = 255;
  File dir = new File("/Users/jaredmednick/Documents/Meownge/MeowngeProcessing/Master/data");
  boolean Init = false;
  boolean hasInit = false;
  int imageMode = 0;
  final static int IMAGE_MODE_ROTATE = 0;
  final static int IMAGE_MODE_HORIZONTAL = 1;
  final static int IMAGE_MODE_VERTICAL = 2;
  
  int ratioWidth;// = ceil(im.width / width) + 1;
  int ratioHeight;// = ceil(im.height / height) + 1;
  
  //File dir = new File("data");
  ImageLoader()
  {

     //imageMode(CENTER);
  }
  
  public void Init()
  {
    if (!hasInit)
    {
      File[] files = dir.listFiles();
      Random rand = new Random();
      imageMode = rand.nextInt(3);
      File file = files[rand.nextInt(files.length)];
  
      // Load a sample image
      im = loadImage(file.getName());
      println("Start ImageLoader");
      //Init = true;
      hasInit = true;
      
      switch(imageMode){
        case IMAGE_MODE_ROTATE:
          println("Rotate image");
          image(im, 0, 0);
          imageMode(CENTER);
          break;
        case IMAGE_MODE_HORIZONTAL:
          ratioWidth = ceil(im.height * width / im.width / im.width) + 2;
          println("Scroll image horizontally, width" + width + " im.Width " + im.width + "ratio " + ratioWidth);
          image(im, 0, 0);
          imageMode(CORNER);
          break;
        case IMAGE_MODE_VERTICAL:
          ratioHeight = ceil(im.width * height / im.height / im.height) + 2;
          println("Scroll image vertically, height" + height + " im.Height " + im.height + "ratio " + ratioHeight);
          image(im, 0, 0);
          imageMode(CORNER);
          break;
      }
    

    }
  }
  
  void Draw()
  {
    float speed = 0.05;
    int imWidth = im.width * height / im.height;
    int imHeight = im.height * width / im.width;
    float x = (millis() * -speed) % imWidth;
    float y = (millis() * -speed) % imHeight;
    
    switch(imageMode){
        case IMAGE_MODE_ROTATE:
          image(im, width/2 - im.width/2, height - im.height/4);
          translate(width/2, height/2);
          rotate(HALF_PI * millis() * 0.001);
          image(im, 0, 0);
          break;
        case IMAGE_MODE_HORIZONTAL:
          for (int i = 0; i < ratioWidth; i++)
          {
            image(im, x + (imWidth * i), 0, imWidth, height);
          }
          //image(im, x, 0, imWidth, height);
          //image(im, x + imWidth, 0, imWidth, height);
          break;
        case IMAGE_MODE_VERTICAL:
          for (int i = 0; i < ratioHeight; i++)
          {
            image(im, 0, y + (imHeight * i), width, imHeight);
          }

          //image(im, 0, y, width, imHeight);
          //image(im, 0, y + imHeight, width, imHeight);
          //image(im, 0, y + (2 * imHeight), width, imHeight);
          break;
    }
    
    
    //if(Init)
    //{
    //  //alphaVal++;
    //  //if (alphaVal == 255) Init = false;
    //}

    //fill(0, 0, 0, alphaVal);
    //rect(0, 0, width, height);
  }
  
  void Reset()
  {
    println("End ImageLoader");
    hasInit = false;
  }
}
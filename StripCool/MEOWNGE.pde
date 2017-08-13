import java.net.*;
import java.util.Arrays;

public class MEOWNGE 
{
  OPC opc;
  int ledCnt = 0;
  int dataStripCount = 0;
  int globalStripCount = 0;
  int tempCnt = 0;
  int noseBrightness = 0;
  boolean goUp = true;
  int upIndex = 0;
  
  private static final int STRIP_COUNT = 54;
  
  //Fixed number of strips, so just make it here.
  MeowngeStrip[] strips = new MeowngeStrip[STRIP_COUNT];
  MeowngeStrip[] right_eye = new MeowngeStrip[8];
  MeowngeStrip[] left_eye = new MeowngeStrip[8];
  MeowngeStrip[] right_ear = new MeowngeStrip[9];
  MeowngeStrip[] left_ear = new MeowngeStrip[9];
  MeowngeStrip[] forehead = new MeowngeStrip[8];
  MeowngeStrip[] nose = new MeowngeStrip[12];

  //This is kind of a pain, think of a better way...
  private static final int RIGHT_EYEBROW_OUTER = 0;
  private static final int RIGHT_EYEBROW_INNER = 1;
  
  //This function will place LEDs along two points given
  //Not perfect, because if the points are two close
  //together and the LED count is too high, you'll have
  //overlapping pixels.
  void createMeowngeStrip(float startX, float startY, 
                        float endX, float endY, 
                        int length,
                        Boolean isEndOfStrip)
  {
    strips[dataStripCount++] = new MeowngeStrip(startX, startY, endX, endY, length);
    
    float nextX = startX, incX;
    float nextY = startY, incY;
    incX = (startX - endX) / length * -1;
    incY = (startY - endY) / length * -1;
    for (int i = ledCnt; i < ledCnt + length; i++)
    {
       opc.led(i, (int)nextX, (int)nextY);
       nextX += incX;
       nextY += incY;
    }
    ledCnt += length;
    if (isEndOfStrip)
    {
      println("Strip " + globalStripCount++ + " starts " + 
        (ledCnt - (length + tempCnt)));
      tempCnt = 0;
    }
    else
      tempCnt += length;
  }
  
  MEOWNGE(OPC opc)
  {
    this.opc = opc;
    
    println("CREATE RIGHT EYE");
    //Create Right Eye
    //2A Right Eyebrow 1 Outer
    createMeowngeStrip(197, 370, 109, 346, 42, true);
    //2B Right Eyebrow 2 Inner
    createMeowngeStrip(198, 371, 254, 447, 40, true);
    //2C Right Eye Frame Inner
    createMeowngeStrip(155, 488, 253, 446, 46, true);
    //2D Right Eye Inner
    createMeowngeStrip(160, 480, 225, 433, 37, true);
    //2E Right Eye Outer
    createMeowngeStrip(148, 479, 177, 420, 32, true);
    //2F Right Eye Frame Outer
    createMeowngeStrip(147, 486, 108, 344, 61, true);
    //2G Right Cheek Upper
    createMeowngeStrip(153, 492, 256, 502, 51, true);
    //2H Right Cheek Lower
    createMeowngeStrip(154, 493, 256, 527, 55, true);
    println();
  
    //Create Right Ear (There is no 3C)
    println("CREATE RIGHT EAR");
    //3A Right Outer Ear
    createMeowngeStrip(32, 307, 32, 148, 64, true);
    //3B Right Inner Ear
    createMeowngeStrip(185, 247, 58, 130, 64, true);
    //3D Right Inside Ear 1
    createMeowngeStrip(33, 306, 110, 224, 47, false);
    //3D Extension for inside tip of right ear
    createMeowngeStrip(32, 114, 58, 130, 11, true);
    //3E Right Inside Ear 2
    createMeowngeStrip(186, 258, 121, 223, 46, false);
    //3E Extension for outside tip of right ear
    createMeowngeStrip(32, 113, 32, 148, 11, true);
    //3F Right Outside Ear Support
    createMeowngeStrip(32, 309, 98, 341, 64, true);
    //3G Right Inside Ear Support
    createMeowngeStrip(182, 255, 110, 344, 64, true);
    //3H Right Ear Outside Support Extension (Tiny!)
    createMeowngeStrip(98, 341, 108, 348, 10, true);
    println();
    
    //Create Forehead
    println("CREATE FOREHEAD");
    //4A, Outside Right Forehead
    createMeowngeStrip(200, 367, 189, 260, 64, true);
    //4B, Inside Right Forehead
    createMeowngeStrip(252, 364, 192, 258, 64, true);
    //4C, Bottom Right Forehead
    createMeowngeStrip(250, 370, 205, 370, 22, true);
    //4D, Upper Right Forehead
    createMeowngeStrip(286, 273, 193, 252, 64, true);
    //4E, Upper Left Forehead
    createMeowngeStrip(295, 274, 386, 252, 64, true);
    //4F, Inside Left Forehead
    createMeowngeStrip(328, 365, 390, 259, 64, true);
    //4G, Outside Left Forehead
    createMeowngeStrip(380, 366, 394, 262, 64, true);
    //4H, Bottom Left Forehead
    createMeowngeStrip(330, 370, 378, 370, 22, true);
    println();
    
    //Create Left Eye
    println("CREATE LEFT EYE");
    //2A Left Eyebrow 1 Inner
    createMeowngeStrip(381, 375, 330, 445, 40, true);
    //2B Left Eyebrow 2 Outer
    createMeowngeStrip(385, 370, 470, 350, 42, true);
    //2C Left Eye Frame Inner
    createMeowngeStrip(424, 486, 331, 451, 46, true);
    //2D Left Eye Inner
    createMeowngeStrip(425, 482, 361, 432, 37, true);
    //2E Left Eye Outer
    createMeowngeStrip(426, 483, 407, 422, 32, true);
    //2F Left Eye Frame Outer
    createMeowngeStrip(427, 484, 469, 349, 61, true);
    //2G Left Cheek Upper
    createMeowngeStrip(428, 485, 328, 500, 51, true);
    //2H Left Cheek Lower
    createMeowngeStrip(429, 486, 325, 528, 55, true);
    println();
    
    //Create Left Ear (no 3C)
    println("CREATE LEFT EAR, start at " + ledCnt);
    //3A Left Outer Ear
    createMeowngeStrip(550, 307, 550, 120, 64, true);
    //3B Left Inner Ear
    createMeowngeStrip(399, 246, 543, 120, 64, true);
    //3D Left Inside Ear 1
    createMeowngeStrip(550, 308, 463, 223, 47, false);
    //3D Extension for inside tip of left ear
    createMeowngeStrip(550, 105, 550, 120, 11, true);
    //3E Left Inside Ear 2
    createMeowngeStrip(396, 251, 461, 224, 64, false);
    //3E Extension for outside tip of left ear
    createMeowngeStrip(550, 105, 543, 120, 10, true);
    //3F Right Outside Ear Support
    createMeowngeStrip(549, 308, 489, 338, 64, true);
    //3G Right Inside Ear Support
    createMeowngeStrip(400, 256, 474, 343, 64, true);
    //3H Right Ear Outside Support Extension (Tiny!)
    createMeowngeStrip(488, 338, 470, 350, 10, true);
    println();
    
    //Create Nose
    println("CREATE NOSE SECTION, start at " + ledCnt);
    //1C Outside Left Nose Lower
    createMeowngeStrip(325, 560, 325, 395, 64, true);
    //1C Outside Left Nose Upper, 23 straight
    createMeowngeStrip(325, 401, 325, 370, 23, false);
    //1C Outside Left Nose Upper, 41 Angled
    createMeowngeStrip(325, 369, 297, 279, 41, true);
    //1A Nose Bridge Upper
    createMeowngeStrip(289, 420, 289, 278, 64, true);
    //1D Mouth Parting, 24 straight
    createMeowngeStrip(289, 590, 289, 545, 24, false);
    //1D Outside Nose Left, 16 Angled
    createMeowngeStrip(289, 545, 325, 521, 16, false);
    //1D Nose Top, 25 Straight
    createMeowngeStrip(324, 520, 255, 520, 25, true);
    //1B Outside Right Nose Upper, 23 straight
    createMeowngeStrip(255, 401, 255, 370, 23, false);
    //1B Outside Right Nose Upper, 41 Angled
    createMeowngeStrip(255, 369, 285, 279, 41, true);
    //1B Outside Right Nose Lower
    createMeowngeStrip(255, 560, 255, 395, 64, true);
    //1E Outside Nose Right, 18 Angled
    createMeowngeStrip(255, 522, 289, 544, 18, true);
    //1A Nose Bridge Lower
    createMeowngeStrip(289, 519, 289, 421, 41, true);
    println();
  }
  
  void update()
  {
    if (noseBrightness > 20)
    {
      goUp = false;
      if (upIndex < STRIP_COUNT)
        strips[upIndex++].setColor(color(random(255), random(255), random(255))); 
    }
    
    if (noseBrightness < 1)
      goUp = true; 
    
    if (goUp == true)
      noseBrightness++;
    else
      noseBrightness--;
      
  }
  
  void show()
  {
    for (int i = 0; i < STRIP_COUNT; i++)
    {
      strips[i].display(); 
    }
  }
  
  void setStripColor(int index, color c)
  {
     if (index < STRIP_COUNT)
     {
       strips[index].setColor(c);
     }
  }
}

private class MeowngeStrip
{
  float startX, startY;
  float endX, endY;
  int ledCnt;
  int index;
  boolean isOn = false;
  color c = color(0, 0, 0);
  
  MeowngeStrip(float startX, float startY, float endX, float endY, int ledCnt)
  {
     this.startX = startX;
     this.startY = startY;
     this.endX = endX;
     this.endY = endY;
     this.ledCnt = ledCnt;
  }
  
  void setColor(color c)
  {
    this.c = c; 
  }
  
  void display()
  {
    strokeWeight(2);
    stroke(c);
    
    line(startX, startY, endX, endY);
  }
}
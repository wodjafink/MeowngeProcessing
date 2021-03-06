import java.net.*;
import java.util.Arrays;

public class MEOWNGE 
{
  OPC opc;
  int ledCnt = 0;
  int globalStripCount = 0;
  int fullStripCount = 0;
  int tempCnt = 0;
  
  final static int NUM_ALL_STRIPS = 55;
  
  meowngeStrip strips[] = new meowngeStrip[55];
  
  //This function will place LEDs along two points given
  //Not perfect, because if the points are two close
  //together and the LED count is too high, you'll have
  //overlapping pixels.
  void createMeowngeStrip(float startX, float startY, 
                        float endX, float endY, 
                        int length,
                        Boolean isEndOfStrip)
    {
      strips[fullStripCount++] = new meowngeStrip(
        (int)startX, (int)startY, 
        (int)endX, (int)endY, 
        length, dot);
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
    {
      // For counting up for substrips
      tempCnt += length;
    }
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
    createMeowngeStrip(396, 251, 461, 224, 47, false);
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
    
    println("Made " + fullStripCount + " strips" );
  }
  
  void update()
  {
    fft.forward(in.mix);
    for (int i = 0; i < fftFilter.length; i++) {
      fftFilter[i] = max(fftFilter[i] * decay, log(1 + fft.getBand(i)));
    }
    
  }
  
  void show()
  {
    for (int i = 0; i < fftFilter.length; i += 3) {   
      color rgb = colors.get(int(map(i, 0, fftFilter.length-1, 0, colors.width-1)), colors.height/2);
      tint(rgb, fftFilter[i] * opacity);
      //Turn this off to see the dots always
      //blendMode(ADD);??
   
      float size = height * (minSize + sizeScale * fftFilter[i]);
      int location = floor(map(size, 0, height * 2,  0, 52));
      //PVector center = new PVector(width * (fftFilter[i] * 0.2), 0);
      //center.rotate(millis() * spin + i * radiansPerBucket);
      //center.add(new PVector(width * 0.5, height * 0.5));
      //strokeWeight(size);
      //stroke(rgb);
      //println("Access" + location);
      imageMode(CENTER);
      //println("Do " + location + " At x " + strips[location].moveX + 
      //  " and y " + strips[location].moveY);
      //println("  From " + strips[location].startX + "," + strips[location].startY
      //  + " to " + strips[location].endX + "," + strips[location].endY);
      for (int j = 0; j < ( NUM_ALL_STRIPS - 1); j++)
      {
        strips[j].update_strip();
        strips[j].display_strip((int)size);
      }
      //image(dot, strips[location].moveX, strips[location].moveY, size, size);
      
      //if (location % 2 == 0)
      //{
      //  image(dot, (255+289) / 2, (522 + 544) / 2);
      //  //line(255, 522, 289, 544);
      //}
      //else
      //{
      //  image(dot, (185 + 58) / 2, (247+130)/2);
      //  //line(185, 247, 58, 130);
      //}
        //image(dot, center.x - size/2, center.y - size/2, size, size);
    }
  }
}

class meowngeStrip
{
  PImage stripImg;
  int moveX, moveY, highX, highY, lowX, lowY;
  int centerX, centerY;
  int startX, startY;
  int endX, endY;
  int leds;
  boolean isAscendingX;
  boolean isAscendingY;
  
  meowngeStrip(int startX, int startY, int endX, int endY, int leds, PImage stripImg)
  {
    this.startX = startX;
    this.startY = startY;
    this.endX = endX;
    this.endY = endY;
    this.leds = leds;
    this.stripImg = stripImg;
    
    if (startX > endX) 
    {
      highX = startX; lowX = endX;  isAscendingX = false;  moveX = endX;
    }
    else if (startX <= endX)
    {
      highX = endX;  lowX = startX;  isAscendingX = true;  moveX = startX;
    }
    
    if (startY > endY)
    {
      highY = startY; lowY = endY;  isAscendingY = false;  moveY = endY;
    }
    else if (startY <= endY)
    {
      highY = endY;  lowY = startY;  isAscendingY = true;  moveY = startY;
    }
    
    centerX = (startX + endX) / 2;
    centerY = (startY + endY) / 2;
  }
  
  void display_strip(int size)
  {
    size += 2;
    image(stripImg, moveX, moveY, size, size);
  }
  
  void update_strip()
  {
     if(isAscendingX)
     {
       if (moveX < highX)
         moveX++; 
       if (moveX == highX)
         isAscendingX = false;
     } else
     {
       if (moveX > startX)
         moveX--; 
       if (moveX == startX)
         isAscendingX = true;
     }
     
     if(isAscendingY)
     {
       if (moveY < highY)
         moveY++; 
       if (moveY == highY)
         isAscendingY = false;
     } else
     {
       if (moveY > startY)
         moveY--; 
       if (moveY == startY)
         isAscendingY = true;
     }
  }
}
// Just reusing two old sketches

class FillWithCircles extends DefaultDrawer
{
  int MIN_RAD = 10;
  int MAX_RAD = 100;
  int m_circleNb;
  int m_radius;
  int alphaVal = 255;

  FillWithCircles(int radius, int circleNb)
  {
    m_radius = radius;
    m_circleNb = circleNb;
  }

  public void Init()
  {
    println("Start FillWithCircles");
    if (alphaVal > 0) alphaVal--;
    fill(0, 0, 0, alphaVal);
    rect(0, 0, width, height);
  }

  //@Override
  void Draw()
  {
    background(255);
    noStroke();

    int centerX = width / 2;
    int centerY = height / 2;

    for (int i = 0; i < m_circleNb; i++)
    {
      float d = random(0, m_radius - MIN_RAD);
      float a = random(0, TWO_PI);
      float x = centerX + d * cos(a);
      float y = centerY + d * sin(a);
      float r = random(MIN_RAD, min(MAX_RAD, m_radius - d));
      color c = lerpColor(#00FF00, #0000FF, (1 + cos(a))/2);

      fill(c);
      ellipse(x, y, r * 2, r * 2);
    }
  }
  
  void Reset()
  {
    println("End FillWithCircles");
    if (alphaVal < 255) alphaVal++;
    fill(0, 0, 0, alphaVal);
    rect(0, 0, width, height);
  }
}

class PulsatingCircles extends DefaultDrawer
{
  int rMove = +5;
  int slowDown = 1;
  int minRadius = 5, maxRadius = 100;
  int radius = minRadius;
  int xPos = (int)random(height);
  int yPos = (int)random(width);
  color c1 = color(random(255), random(255), random(255));
  color c2 = color(random(255), random(255), random(255));
  int alphaVal = 255;
  boolean Init = false;

  PulsatingCircles() {}

  public void Init()
  {
    println("Start PulsatingCircles");
    Init = true;
  }

  //@Override
  void Draw()
  {
    background(0);
    fill(lerpColor(c1, c2, (float) radius / (float) maxRadius));

    ellipse(xPos, yPos, radius, radius);
    if (frameCount % slowDown == 0)
    {
      radius += rMove;
      if (radius > maxRadius)
        rMove = -1;
      else if (radius < minRadius)
        rMove = +1;
    }
    
    if(Init)
    {
      alphaVal++;
      if (alphaVal == 255) Init = false;
    }
    fill(0, 0, 0, alphaVal);
    rect(0, 0, width, height);
  }
  
  void Reset()
  {
    println("End Pulsating Circles");
    while (alphaVal > 0)
    {
      alphaVal--;
      fill(0, 0, 0, alphaVal);
      rect(0, 0, width, height);
    }
  }
}

class Rain extends DefaultDrawer
{
  Drop[] drops = new Drop[500];
  Rain()
  {
    for (int i = 0; i < drops.length; i++)
    {
      drops[i] = new Drop();
    }
  }
 
  void Init()
  {
    
  }
  
  void Draw()
  {
    background(0);
    for (int i = 0; i < drops.length; i++)
    {
       drops[i].show();
       drops[i].fall();
    }
  }
  
  
  void Reset()
  {
    
  }
}

class Drop {
  float x = random(width);
  float y = random(-500, -50);
  float z = random(0, 10);
  float yspeed = map(z, 0, 20, 1, 3);
  float len = map(z, 0, 20, 10, 20);
  int r = (int)random(255);
  int g = (int)random(255);
  int b = (int)random(255);
  
  void fall() {
    y = y + yspeed;
    float grav = map(z, 0, 20, 0.01, 0.2);
    yspeed = yspeed + grav;
    
    if (y > height) {
      y = random(-200, -100); 
      yspeed = map(z, 0, 20, 4, 10);
    }
  }
  
  void show() {
    float thick = map(z, 0, 20, 1, 3);
    strokeWeight(thick);
    stroke(g+128, g, 0);
    line(x,y,x,y+len); 
  }
}

class Metaballs extends DefaultDrawer
{
  Blob[] blobs = new Blob[15];
  int metafactor;// = (int)random(255);
  boolean hasInit = false;
  
  Metaballs()
  {
    colorMode(HSB);
    for (int i = 0; i < blobs.length; i++)
    {
      blobs[i] = new Blob(random(width), random(height)); 
    }
  }
  
  void Init()
  {
    if (!hasInit){
      metafactor = (int)random(255);
      colorMode(HSB);
      hasInit = true;
    }
  }
  
  void Draw()
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
          pixels[index] = color(sum % metafactor, 255, 255);
       }
    }
    
    updatePixels();
  
    for (Blob b : blobs)
    {
      b.update();
      //b.show();
    }
  }
  
  void Reset()
  {
    colorMode(RGB);
    hasInit = false;
  }
}

class Blob {
  PVector pos;
  float r;
  PVector vel;
  
  Blob (float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D();
    vel.mult(random(2,5));
    r = random(120, 400);
  }
  
  void update()
  {
    pos.add(vel); 
    
    if (pos.x > width || pos.x < 0)
    {
      vel.x *= -1; 
    }
    if (pos.y > height || pos.y < 0)
    {
      vel.y *= -1; 
    }
  }
  
  void show() {
    noFill();
    stroke(0);
    strokeWeight(4);
    ellipse(pos.x, pos.y, r * 2, r * 2);
  }
}

class SlidingRings extends DefaultDrawer{
  float pos1 = 0;
  float pos2 = 0;
  float pos3 = 0;
  boolean hasInit = false;
  int redness, greenness, blueness;
  
  SlidingRings()
  {
    strokeWeight(60);
    noFill();
  }
  
  void Init()
  {
    if (!hasInit)
    {
      colorMode(HSB);
      hasInit = true; 
      redness = (int)random(255);
      greenness = (int)random(255);
      blueness = (int)random(255);
    }
  }
  
  void Draw()
  {
    background(0);
    pos1 = cos(radians(frameCount));
    pos2 = cos(radians(frameCount*1.5));
    pos3 = cos(radians(frameCount*2));
    
    for(int j = 0; j < 3; j++){
      if(j == 0){
        stroke(redness,255,255,150);
        //stroke(redness,0,0,150);
        ellipse((float(width/3)*pos1)+(height/2),height/2, 200,200);
      }
      else if(j == 1){
        stroke(greenness,255,255,150);
        //stroke(0,greenness,0,150);
        ellipse((float(width/3)*pos2)+(height/2),height/2, 300,300);
      }
      else if(j == 2){
        stroke(blueness,255,255,150);
        //stroke(0,0,blueness,150);
        ellipse((float(width/3)*pos3)+(height/2),height/2, 400,400);
      }
    }
  }
  
  void Reset()
  {
    colorMode(RGB);
    hasInit = false;
  }
}

class lines extends DefaultDrawer{
  //line theLines[];
  ArrayList<line> theLines = new ArrayList<line>();
  lines()
  {
    
  }
  
  void Init()
  {
    
  }
  
  void Draw()
  {
    blendMode(BLEND);
    background(0);
    blendMode(ADD);
    translate(width/2, height/2);
    for (line l : theLines)
    {
      l.update();
      l.show();
    }
    
    for (int i = 0; i < theLines.size(); i++)
    {
      line l = theLines.get(i);
       if (l.z < 0.0) theLines.remove(i);
    }
    
    if (random(1) > 0.2)
    {
      theLines.add(new line()); 
    }
  }
  
  void Reset()
  {
    blendMode(BLEND);
  }
}

class line {
  float posA = random(PI * 2);
  float posR = sqrt(width * width + height * height);
  
  PVector pos;// = new PVector(posR * cos(posA), posR * sin(posA));
  float z;
  float angle;
  
  line()
  {
    z = 1;
    angle = posA + (PI / 2);
    pos = new PVector(posR * cos(posA), posR * sin(posA));
  }
  
  void update()
  {
    z -= 0.002; 
  }
  
  void show()
  {
    PVector P1, P2;
    float l = sqrt(width * width + height * height);
    pos.mult(z);
    P1 = pos.add( new PVector(cos(angle), sin(angle)).mult(l));
    P2 = pos.sub( new PVector(cos(angle), sin(angle)).mult(l));
    stroke(255, 90, 30, map(sqrt(z), 0.1, 1, 0, 255));
    strokeWeight(map(this.z, 0, 1, 1, 80));
    line(P1.x, P1.y, P2.x, P2.y);
  }
}

class circlesAndSquares extends DefaultDrawer
{
  
  float r = 0;
  float col =30;
  float inc = 0.5;
  float circle_size;
  boolean hasInit = false;
  
  circlesAndSquares()
  {
    
  }
  
  void Init()
  {
    if (!hasInit)
    {
      circle_size = random(5);
      hasInit = true;
      smooth();
      noStroke();
      colorMode(HSB, 360, 100, 100);
      background(10, 0, 0);
    }
  }
  
  void Draw()
  {
    //background(0);
    translate(width/2, height/2);
    fill(col, 100, 100);
    rotate(r);
    if(inc<0)
      ellipse( r, 10, circle_size, circle_size);
    else
      rect( r, 10, circle_size, circle_size);

    if (r>=250||r<=-250)
    {
      background(random(100), 0, 0);
      r = 0;
      inc = random(-3,3);
      
      if(inc >= -0.5 && inc <= 0.5)
      {
        inc = 1;
      }
      circle_size = random(5, 25);
    } 
    else 
    {
      r = r + inc;
      circle_size = circle_size +0.2;
    }
    
    col = col + 0.2;
    if (col >=360) 
    {
      col = 1;
    } 
  }
  
  void Reset()
  {
    hasInit = false;
  }
}

class Acid extends DefaultDrawer
{
  int pal []=new int [128];
  int[] cls;
  boolean hasInit = false;
   
  Acid()
  {

  }
  
  void Init()
  {
    if (!hasInit)
    {
      float s1,s2,s3;
      float additive1 = random(255);
      float additive2 = random(255);
      for (int i=0;i<128;i++)
      {
        s1=sin(i*PI/25);
        s2=sin(i*PI/50-PI/4);
        s3=sin(i*PI/50+PI/4);
        pal[i]=color(additive1+s2*128,additive2+s3*128,s1*128);
      }
    
      cls = new int[width*height];
      for (int x = 0; x < width; x++)
      {
        for (int y = 0; y < height; y++)
        {
          cls[x+y*width] = (int)((127.5 + +(127.5 * cos(x / 32.0)))+ (127.5 + +(127.5 * sin(y / 32.0))) + (127.5 + +(127.5 * sin(sqrt((x * x + y * y)) / 32.0)))  ) / 4;
        }
      }
      hasInit = true;
    }
  }
   
  void Draw()
  {
    loadPixels();
    for (int pixelCount = 0; pixelCount < cls.length; pixelCount++)
    {                    
      pixels[pixelCount] =  pal[(cls[pixelCount] + frameCount)&127];
    }
    updatePixels(); 
  }
   
  void Reset()
  {
    hasInit = false;
  }
}
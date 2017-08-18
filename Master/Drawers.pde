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
  int metafactor = (int)random(255);
  
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
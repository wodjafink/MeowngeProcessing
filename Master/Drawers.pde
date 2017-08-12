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
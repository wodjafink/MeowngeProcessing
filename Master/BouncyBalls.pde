float spring = 0.05;
float gravity = 0.01;
float friction = -0.9;
int numBalls = 22;

class BouncyBalls extends DefaultDrawer
{
  boolean hasInit = false;
  Ball[] balls = new Ball[numBalls];
  
  BouncyBalls()
  {

  }
  
  void Init()
  {
    if (!hasInit)
    {
      for (int i = 0; i < numBalls; i++)
      {
        balls[i] = new Ball(random(width), random(height), random(30, 70), i, balls);
      }
      noStroke();
      hasInit = true;
      println("Start BouncyBalls");
    }
  }
  
  void Draw()
  {
    background(0);
    for (Ball ball : balls)
    {
      ball.collide();
      ball.move();
      ball.display();  
    }
  }
  
  void Reset()
  {
    hasInit = false;
  }
}

class Ball {
  
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;
  int colorChangeTime = 0;
  color ballColor;
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
    ballColor = color(random(255),random(255),random(255));
  } 
  
  void collide() {
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
        if (millis() - colorChangeTime > 500)
        {
           colorChangeTime = millis(); 
           //ballColor = color(random(255),random(255),random(255));
        }
      }
    }   
  }
  
  void move() {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction; 
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }
  
  void display() {
    fill(ballColor);
    ellipse(x, y, diameter, diameter);
  }
}
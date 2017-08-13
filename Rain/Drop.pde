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
    //stroke(0, 0, 255);
    line(x,y,x,y+len); 
  }
}
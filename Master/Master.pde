import java.io.*;
import java.util.*;

OPC opc;
MEOWNGE meownge;

ArrayList drawers = new ArrayList();
Drawer currentDrawer;
int currentDrawerIdx;
int currentDuration;

interface Drawer
{
  public void Draw();
  public int GetDuration();
  public void SetDuration(int d);
  public void Reset();
  public void Init();
}

abstract class DefaultDrawer implements Drawer
{
  protected int m_duration = 5;

  public abstract void Draw();
  //@Override
  public int GetDuration()
  {
    return m_duration;
  }
  //@Override
  public void SetDuration(int d)
  {
    m_duration = d;
  }
  
  public abstract void Reset();
  public abstract void Init();
}

class Texter extends DefaultDrawer
{
  private String m_message;
  private int m_color;
  int alphaVal = 0;

  public Texter(int d, String m, int c)
  {
    m_duration = d;
    m_message = m;
    m_color = c;
  }

  public void Init()
  {
    if (alphaVal > 0) alphaVal--;
    fill(0, 0, 0, alphaVal);
    rect(0, 0, width, height);
  }

  //@Override
  public void Draw()
  {
    background(0);
    textAlign(CENTER);
    fill(m_color);
    noStroke();
    // Suppose textFont() have been called
    text(m_message, width / 2, height / 2);
  }
  
  public void Reset()
  {
    if (alphaVal < 255) alphaVal++;
    fill(0, 0, 0, alphaVal);
    rect(0, 0, width, height);
  }
}

void setup()
{
  size(600, 600);

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  meownge = new MEOWNGE(opc);

  //drawers.add(new Texter(7, "Demonstrating drawing in sequence", #FF1100));
  //drawers.add(new Texter(5, "Fill With Circles 1", #AA8800));
  //drawers.add(new FillWithCircles(250, 222));
  //drawers.add(new Texter(5, "Pulsating Circles", #BB7700));
  //Drawer dr = new PulsatingCircles();
  //dr.SetDuration(5);
  //drawers.add(dr);
  drawers.add(new Metaballs());
  drawers.add(new ImageLoader());
  drawers.add(new lines());
  drawers.add(new MatrixBalls());
  drawers.add(new BouncyBalls());
  drawers.add(new Acid());
  drawers.add(new circlesAndSquares());
  drawers.add(new SlidingRings());
  drawers.add(new Rain());
  //drawers.add(new Visualizer());
  //drawers.add(new Texter(5, "Fill With Circles 2", #CC6600));
  //drawers.add(new FillWithCircles(350, 333));
  //drawers.add(new Texter(10, "END", #FF0000));

}

void draw()
{
  currentDrawer = (Drawer) drawers.get(currentDrawerIdx);
  currentDrawer.Init();
  currentDrawer.Draw();
  int time = millis() / 1000;
  if (time - currentDuration > currentDrawer.GetDuration())
  {
    currentDrawerIdx = (int)random(drawers.size());
    currentDuration = time;
    if (currentDrawerIdx == drawers.size())
    {
      //noLoop();
      currentDrawerIdx = 0;
    }
    currentDrawer.Reset();
  }

}

//Useful, and obvious!
void mousePressed() {
   background(0);
   exit();
}
package vanim.mfunc;

import processing.core.*;
import processing.event.*;

import java.text.DecimalFormat;
import java.lang.*;

public class planar extends PApplet {

public static DecimalFormat df = new DecimalFormat("###.#");
float e = 1;
CartesianPlane plane;
Scaling c = new Scaling(0);
//int max = -width/2;
float angle;
public static PFont myFont, italics;
public static PGraphics canvas;
float inc = 0;
public static Arrow arr;
PImage narrator, vectorV;
public static final int WIDTH = 1920;
public static final int HEIGHT = 1080;
Narrator n;

public void setup() {
  
  myFont = createFont("cmunbmr.ttf", 150, true);
  italics = createFont("cmunbmo.ttf",150,true);
  textFont(myFont, 64);
  canvas = createGraphics(1920, 1080, P2D);
  plane = new CartesianPlane(this,canvas,0.5f,0.5f);
  arr = new Arrow(canvas,cos(inc), sin(inc));
  
  canvas.shapeMode(CENTER);
  rectMode(CENTER);
  narrator = loadImage("cM3.png");
  vectorV = loadImage("vectorV.png");
  vectorV.resize(100,100);
  n = new Narrator(canvas);
}


public class slowLine {
  int count = 0;
  public boolean slowLine(float x1, float y1, float x2, float y2) {
    //-0.2*x*(x-5) is the equation... for x = time since called
    if (count > 99) {
      line(x1, y1, x2, y2);
      return false;
    }
    count++;
    float diffX = (x2 - x1)/100;
    float diffY = (y2 - y1)/100;
    stroke(255);
    strokeWeight(5);
    line(x1, y1, x1+diffX*count, y1+diffY*count);
    return true;
  }
}

public void directions() {
  plane.rotatePlane(angle);
  arr.setVector(cos(inc),sin(inc));
 // plane.drawVector(arr);
  //  plane.createPoint(20,-20);
  arr.addPoint(plane.sX*arr.vector.x,-plane.sY*arr.vector.y,plane.delVal); //no cool color effect!
  arr.graph(canvas,plane.delVal);
  inc += 0.04f;
  //  plane.createPoint(40,20);
}


public void mouseWheel(MouseEvent event) {
  e += -0.07f*event.getCount();
}

public void increaseScale() {
  e += 0.01f;
}

public void keyPressed() {
  switch (key) {
  case 'v':
    angle = PI/2;
    break;
  case 'c':
    angle = 0;
    break;
  case 'd':
    plane.restrictDomain(-PI/2, PI/2);
    break;
  case 's':
    plane.sY *= 1.1f;
    break;
  case 'x':
    frameRate(2);
    break;
  }
}

public void draw() {
  background(0);
  scale(e);
  plane.run(canvas);
  plane.generatePlane();
  // plane.graph();
  directions();
  n.narrate();
  plane.display();
  /* debug space */
  // bruv();
  /* debug space */
  //saveFrame("basicVector/line-######.png");
  // directions();
}

  public void settings() {  size(1920, 1080, P2D);  smooth(8); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "planar" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

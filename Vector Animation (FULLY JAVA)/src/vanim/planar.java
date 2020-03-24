package vanim;
import vanim.mfunc.*;
import vanim.shapes.*;
import processing.core.*;
import processing.event.*;


import java.text.DecimalFormat;
import java.lang.*;
import java.util.*;

public class planar extends PApplet {

public static DecimalFormat df = new DecimalFormat("###.#");
float e = 1;
CartesianPlane plane;
Scaling c = new Scaling(0);
float angle;
public static PFont myFont, italics;
public static PGraphics canvas;
float inc = 0;
public static Arrow arr;
PImage narrator, vectorV;
public static final int WIDTH = 1920;
public static final int HEIGHT = 1080;
Narrator n;
List<Boolean> directions = new ArrayList<>();
/* sprites */
MObject b, crLine;
/* sprites */

public void setup() {
  
  myFont = createFont("vanim\\data\\cmunbmr.ttf", 150, true);
  italics = createFont("vanim\\data\\cmunbmo.ttf",150,true);
  textFont(myFont, 64);
  canvas = createGraphics(1920, 1080, P2D);
  plane = new CartesianPlane(this,canvas,0.5f,0.5f);
  arr = new Arrow(canvas,cos(inc), sin(inc));
  
  canvas.shapeMode(CENTER);
  rectMode(CENTER);
  narrator = loadImage("vanim\\data\\cM3.png");
  vectorV = loadImage("vanim\\data\\vectorV.png");
  vectorV.resize(100,100);
  n = new Narrator(canvas);

  /* Sprites */
  b = new BigCircle(canvas,0,0,(plane.sX+plane.sY)/2.0f,0.04f,plane.delVal);
  crLine = new Line(canvas,0,0,plane.sX*cos(0.3f),plane.sY*sin(0.5f),4,255);
  /* Sprites */
}

public void directions() {
  plane.rotatePlane(angle);
  arr.setVector(cos(inc),sin(inc));
 // plane.drawVector(arr);
  //  plane.createPoint(20,-20);
  //arr.addPoint(plane.sX*arr.vector.x,-plane.sY*arr.vector.y,plane.delVal); //no cool color effect!
  //arr.graph(canvas,plane.delVal);
  //inc += 0.04f;
  //  plane.createPoint(40,20);

  /* Maybe think about a MObject[] or ArrayList<MObject> where display can be called on everyone */
  b.display();
  crLine.display();
}


public void mouseWheel(MouseEvent event) {
  e += -0.07f*event.getCount();
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
    String[] appletArgs = new String[] {  planar.class.getCanonicalName() };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

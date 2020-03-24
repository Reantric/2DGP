import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 
import processing.core.*; 
import java.util.*; 
import java.text.DecimalFormat; 
import java.lang.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class planar extends PApplet {


float e = 1;
CartesianPlane plane;
Scaling c = new Scaling(0);
int max = -width/2;
float angle;
PFont myFont, italics;
PGraphics canvas;
float inc = 0;
Arrow arr;
PImage narrator, vectorV;
final int WIDTH = 1920;
final int HEIGHT = 1080;

public void setup() {
  
  myFont = createFont("cmunbmr.ttf", 150, true);
  italics = createFont("cmunbmo.ttf",150,true);
  textFont(myFont, 64);
  canvas = createGraphics(1920, 1080, P2D);
  plane = new CartesianPlane(0.5f,0.5f, canvas);
  arr = new Arrow(canvas,cos(inc), sin(inc));
  
  canvas.shapeMode(CENTER);
  rectMode(CENTER);
  narrator = loadImage("cM3.png");
  vectorV = loadImage("vectorV.png");
  vectorV.resize(100,100);
  setupNarrator();
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
  narrate();
  plane.display();
  
  /* debug space */
  // bruv();
  /* debug space */
  //saveFrame("basicVector/line-######.png");
  // directions();
}


public class Arrow extends MObject {
  PVector vector;
  boolean follow;
  float triangleSize;
  double xVal;
  List<float[]> coords;
  int coordsSize;
  int optimalDelVal;
  
  public Arrow(PGraphics c, float x, float y){
    super(c,x,y,0);
    vector = new PVector(x,y);
    coords = new ArrayList<float[]>();
    coordsSize = 0;
    optimalDelVal = 0;
  }
  
 /* public Arrow(PGraphics c, float tS, boolean graphDependent,double xV){ //oh god this is horrible!
    super()
    triangleSize = tS;
    follow = graphDependent;
    xVal = xV;
    vector = new PVector(0,0);
    coords = new ArrayList<float[]>();
    coordsSize = 0;
    optimalDelVal = 0;
  } */
  
  public void drawArc(PGraphics c){ // apparently angle is a processing word? who woulda thought!
    float angle = vector.heading();
    if (angle < 0) angle = TAU + vector.heading();
    c.noFill();
    c.stroke(255);
  //  println(angle);
    c.arc(0, 0, 60, 60, -angle%TAU+radians(0.2f), radians(0.2f));
  }
  
  public void setVector(float x, float y){
    vector.set(x,y);
  }
  
  public void addPoint(float x, float y){
    coords.add(new float[]{x,y});
    coordsSize++;
   // println(coordsSize);
  }
  
  public void addPoint(float x, float y,int delVal){
    if (coordsSize < delVal){
      coords.add(new float[]{x,y});
      coordsSize++;
    }
   // println(coordsSize);
  }
  
  public void graph(PGraphics c, int delVal){
    /* float epsX = (coords.get(coordsSize-1)[0]+0.001)/(coords.get(0)[0]+0.001); //buffer
    float epsY = (coords.get(coordsSize-1)[1]+0.001)/(coords.get(0)[1]+0.001); //buffer */
    
    boolean epsX = coords.get(0)[0]/coords.get(coordsSize-1)[0] > 0.99f && coords.get(0)[0]/coords.get(coordsSize-1)[0] < 1.01f; // x does not start/end at 0 !
    boolean epsY = coordsSize > 1 && coords.get(coordsSize-2)[1] > coords.get(0)[1] && coords.get(coordsSize-1)[1] <= coords.get(0)[1];
     
   //  if (coordsSize > 1)
      //  println(String.format("%f < %f && %f >= %f",coords.get(coordsSize-2)[0],coords.get(0)[0],coords.get(coordsSize-1)[0],coords.get(0)[0]));
    
   // println(coords.get(0)[0]/coords.get(coordsSize-1)[0]);
    if (epsX && epsY){
      optimalDelVal = coordsSize;
     // println("Optimal delVal: " + optimalDelVal);
  //    stop();
    }
    
    if (coordsSize > delVal){
      println("is this ever happening?");
      coords.remove(0);
      coordsSize--;
    }
    
    for (int i = 0; i < coordsSize-1; i++){
      c.stroke(Useful.getColor(i,0,delVal),255,255);
      c.strokeWeight(5);
      c.line(coords.get(i)[0],coords.get(i)[1],coords.get(i+1)[0],coords.get(i+1)[1]);
    }
  }
  
  public void doStuff(float easeInc){
     // vectorMag = vector.mag();
      
    /*  if (vector.x > xVal && vector.x < 0){
        this.incEase(easeInc);
        super.doStuff();
      }
      
      if (vector.x > 0){
        this.setChange(triangleSize);
     
        if (follow){
          this.reset();
          easing = 0.006;
          follow = false;
        }
        
        this.incEase(easeInc);
        super.doStuff();
      } */
      
     // System.out.println(this.vector);
    //  System.out.println(vectorMag);
      
  }
  
  public float getMag(float sX, float aR){
    if (follow && vector.x > 0)
      return aR*sX*vector.mag();
      
    return aR*(sX*vector.mag() - 16);  //-16:?
  }
  
  public void display(Object... obj){
    
  }
  
}



DecimalFormat df = new DecimalFormat("###.#");

public class CartesianPlane extends MObject implements Plane { // Work on mouseDrag after!
    float xValue;
    float yValue;
    float transparency = 255;
    float sX;
    float sY;
    float startingX;
    float startingY;
    float rescaleX;
    float rescaleY;
    float scaleFactor;
    float max = 0; //counter
    float currentColor = 0;
    boolean restrictDomain = false;
    float restrictedDomainX1;
    float restrictedDomainX2;
    List<Double> randArr = new ArrayList<Double>();
    float finalValue;
    PGraphics canvas;
    float aspectRatio;
    int delVal;
    
    /* Object initializations */  // Create color object soon for animateVector();
    List<PVector> points = new ArrayList<PVector>();
    Scaling scaler = new Scaling(0);
    Scaling fadeGraph = new Scaling();
    Easing slowRotate = new Easing(0);
    Easing animVector = new Easing(0); // change later
    Easing originTriangle = new Easing(0,12);
   // Arrow traceGraphF = new Arrow(12,true,xValue);
   // Arrow traceGraphG = new Arrow(12,true,xValue);
    /* Object initializations */
    
    
    /**
     *
     * @param xSpace Distance between x ticks
     * @param ySpace Distance between y ticks
     */
    public CartesianPlane(float xSpace, float ySpace,PGraphics p){
        super(p,0,0,p.width,p.height,0);
        xValue = xSpace;
        yValue = ySpace;
        canvas = p;
        rescaleX = (float) canvas.width/WIDTH;
        rescaleY = (float) canvas.height/HEIGHT;
        sX = 200/xValue * rescaleX;
        sY = 200/yValue * rescaleY;
        scaleFactor = 6/5.0f * xValue/100.0f;
        scaleFactor = 0.06f; // debug
        startingX = (float) Useful.floorAny(-canvas.width/(2*sX),xValue); // <---- Issues here when resizing canvas 
        startingY = (float) Useful.floorAny(-canvas.height/(2*sY),yValue); // <---- Issues here when resizing canvas 
        max = startingX - xValue/5; // should start at 25
        aspectRatio = (WIDTH/1080)/(rescaleX/rescaleY);
        delVal = 159;
        println("please: " + WIDTH + " diff: " + width);

    }
    
    /**
     *
     * Creates a 2D Cartesian Plane with an x axis and a y axis
     */
    public void generatePlane(){
       currentColor = Useful.getColor(max,startingX,-startingX);
       canvas.beginDraw();
       canvas.background(0);
       canvas.textFont(myFont);
       canvas.textSize(38);
       canvas.textAlign(CENTER,CENTER);
       canvas.colorMode(HSB);
       canvas.translate(canvas.width/2,canvas.height/2);
       canvas.stroke(150,200,255);
       canvas.strokeWeight(4);
       
       
     //  pushMatrix();
       canvas.rotate(slowRotate.incrementor); //-PI/2
                
       for (float x = startingX; x < -startingX; x += xValue/2){
          if (x == 0) continue;
          
          if (x % xValue == 0)
            canvas.strokeWeight(4);
          else
            canvas.strokeWeight(1.5f);
            
          canvas.line(sX*x,sY*startingY,sX*x,sY*-startingY);
  
        }
        
        
        for (float y = startingY; y < -startingY; y += yValue/2){
          if (y == 0) continue;
          
          if (y % yValue == 0)
            canvas.strokeWeight(4);
          else
            canvas.strokeWeight(1.5f);
            
          canvas.line(-sX*startingX,sY*y,sX*startingX,sY*y);
         
        }
        
        canvas.stroke(0,0,255);
        canvas.strokeWeight(4);
        
        canvas.line(-sX*startingX,0,sX*startingX,0);
        canvas.line(0,-sY*startingY,0,sY*startingY);
        
     //   popMatrix();

        
    }
    
    /**
    * Label all axes
    */
    public void labelAxes(){
      canvas.textSize(42);
      canvas.textAlign(CENTER);
      canvas.rectMode(CENTER);
      for (float x = startingX; x < -startingX; x += xValue){ //-width/(2*sX) - xValue/5 + xValue, starting 0,0 at width/2, height/2

            if (x == 0) continue;
            
            String tX = df.format(x);
            canvas.noStroke();
            canvas.fill(0,0,0,125);
            canvas.rect(sX*x,30,60 + (tX.length()-3)*10,56);
            canvas.fill(255);
            if (x > 0)
              canvas.text(tX,sX*x,44);
            else
              canvas.text(tX,sX*x-8,44);
          }
      
      canvas.textAlign(RIGHT);
      for (float y = startingY; y < -startingY; y += yValue){
          if (y == 0) continue;
          canvas.text(df.format(-y),-12,sY*y-12);
        }

    }
    
    public void display(Object... obj){
      labelAxes();
      canvas.endDraw();
      //PImage frame = canvas.get(); Much more laggy!
      //pushMatrix();
      //translate(canvas.width/2,canvas.height/2);
      stroke(currentColor,255,255);
      strokeWeight(7);
      noFill();
      rect(pos.x,pos.y,canvas.width,canvas.height);
      image(canvas,pos.x,pos.y);
     // popMatrix();
    }
    

    /**
     * Graph any function
     */
    public void graph(){
      float sMax, endG;
      if (restrictDomain){
        sMax = restrictedDomainX1;
        endG = restrictedDomainX2;
      } else {
        sMax = startingX;
        endG = max;
      }
      
   //   loadRandArr();

    //  traceGraphF.vector.set(max,f(max+scaleFactor) * aspectRatio); // just the aspect ratios!
    //  traceGraphG.vector.set(max,g(max+scaleFactor) * aspectRatio);

      canvas.strokeWeight(5);
      canvas.strokeCap(ROUND);
      for (float i = startingX; i < max; i+=scaleFactor){
        if (i < sMax || i > endG){
           canvas.stroke(125,255,255,fadeGraph.fadeOut(0.01f));
        } else
           canvas.stroke(Useful.getColor(i,startingX,-startingX),255,255);
        
        /* Optimize graph, only use if no autoscale! */

        /*
        for (int t = 0; t < 5 && f(i) > -startingY; t++){
          float jumpDistance = 5*scaleFactor;
          if (f(i+jumpDistance) < -startingY){
            finalValue = jumpDistance;
          }
        }
        max = finalValue - 5*scaleFactor;
        */
        
        /* Optimize graph, only use if no autoscale! */
        
        canvas.line(sX*i,-sY*f(i),sX*(i+scaleFactor),-sY*(f(i+scaleFactor)));
        canvas.line(sX*i,-sY*g(i),sX*(i+scaleFactor),-sY*(g(i+scaleFactor)));
        

      }
      
      if (max < -startingX) max+=scaleFactor;
      

      
     if (max > -2.88f && max < 2.88f) max -= 0.058f;
    //  println("x: " + max + " y: " + f(max));
   //   drawVector(traceGraphF);
    //  drawVector(traceGraphG);
    }

      
    public long factorial(int number) {
        long result = 1;

        for (int factor = 2; factor <= number; factor++) {
            result *= factor;
        }

        return result;
    }
    

    
    /**
     *
     * @param x Input to the function (x-coord)
     * @return Output to the function (y-coord)
     */
    public float f(float x){
      
      return 0.2f*x;
      //(float) (double) randArr.get((int) x + 25);
    }
    
   public float g(float x){
      return x < 0 ? -4*sin(x): (float) -log(x);
   }

    public void loadRandArr(){
      randArr.add(10*Math.random() - 5);
    }
    /**
     *
     * @param x1 Left side of domain restriction
     * @param x2 Rigt side of domain restriction
     * Restrict the domain
     */
    public void restrictDomain(float x1, float x2){
      restrictedDomainX1 = x1;
      restrictedDomainX2 = x2;
      restrictDomain = true;
    }

    /**
     *
     * @param theta Angle to be inputted
     * Rotates the plane by theta degrees
     */
    public void rotatePlane(float theta){ // To be changed with Easing class!
      
      slowRotate.setChange(theta);
      slowRotate.incEase(1.045f);
      slowRotate.doStuff();
      
      /* if (slowRotate.easing < 0.05 && !slowRotate.isEqual())
          slowRotate.incEase(1.045);
        
        
      if (!slowRotate.isEqual())
          slowRotate.incValue();
       

        if (slowRotate.isEqual())
          slowRotate.reset(); */
        

    }
   
    
    /**
    * Get derivative given two values
    */
    public void derivative(float y1, float y2, float distX){
      canvas.stroke(255);
      canvas.line(sX*(max+2),sY*y1,sX*(max-2),sY*y2);
    }
    
    public void autoscale(){
      // To be implemented
    }
    
    /**
    * @param x x-coordinate of point
    * @param y y-coordinate of point
    * Creates a visible point at that location
    */
    public void createPoint(float x, float y){
      
      points.add(new PVector(x,y));

      canvas.stroke(255,scaler.fadeIn(9));
      canvas.fill(255,scaler.getTransp());
      canvas.circle(x,y,20);
  }
  
  /**
  * @param v Vector to be drawn
  * Draws vector in Cartesian Space
  */
  public void drawVector(Arrow arrow){ //no need to graph and that stuff, just show vector!
    PVector v = arrow.vector; // aliases
    arrow.drawArc(canvas);
    canvas.colorMode(HSB); 
    float triangleSize;
    canvas.pushMatrix();

        
      arrow.doStuff(1.045f);

     
     triangleSize = arrow.triangleSize;
     canvas.strokeWeight(arrow.triangleSize * 10.0f/12);


      float rotationAngle = v.heading();
      //should draw Ellipse but is drawing circle (FIX FOR OTHER RES OF CANVAS)
      float magnitude = arrow.getMag(sX,aspectRatio); // max < 0 ? sX*v.mag() - 16 : sX*v.mag(); //arrow.vectorMag; // 6 works...?! apply ease to this v.mag() - 6

      canvas.stroke(currentColor,255,255);
      canvas.strokeCap(ROUND);
      

      
      /* text */
      canvas.fill(Useful.getColor(arrow.coordsSize,0,delVal),255,255);
      
      if (TAU + rotationAngle > 3*PI/2 && rotationAngle < 0)
        Useful.rotatedText(df.format(degrees(rotationAngle > 0 ? rotationAngle : TAU + rotationAngle))+"°",canvas,sX*v.x/4,-sY*v.y/4,PI-rotationAngle);
      else
        Useful.rotatedText(df.format(degrees(rotationAngle > 0 ? rotationAngle : TAU + rotationAngle))+"°",canvas,sX*v.x/4.75f,-sY*v.y/4.75f,PI-rotationAngle);
        
      canvas.textSize(80);
      canvas.fill(255,255,255);
      Useful.rotatedText(Useful.propFormat(v.mag()),canvas,sX*v.x/2 ,-sY*v.y/2,PI-rotationAngle);
      /* text */
    
      canvas.rotate(-rotationAngle);

      canvas.line(0,0,magnitude,0);
      
      canvas.beginShape(TRIANGLES);
        canvas.vertex(magnitude - triangleSize*1.5f + 8,-triangleSize);
        canvas.vertex(magnitude + 8, 0);
        canvas.vertex(magnitude - triangleSize*1.5f + 8,triangleSize);
      canvas.endShape();
     // canvas.triangle(magnitude-triangleSize*1.6,triangleSize,magnitude-triangleSize*1.6,-triangleSize,magnitude,0);
      
    canvas.popMatrix();
    
    arrow.addPoint(sX*v.x,-sY*v.y);
    arrow.graph(canvas,delVal); //delVAL
    /* overlaying text */
     canvas.textSize(42);
     canvas.fill(128,255,255);
     if (PI-rotationAngle < 3*PI/2 && PI-rotationAngle > PI/2)
       canvas.textAlign(LEFT,CENTER);
     else
       canvas.textAlign(RIGHT,CENTER);
     canvas.text(String.format("[cos(%s),sin(%s)]",df.format(v.x),df.format(v.y)),1.09f*sX*v.x,1.09f*-sY*v.y);
    /* overlaying text */
    
    /* cherry on top */
    canvas.noStroke();
    canvas.fill(Useful.getColor(arrow.coordsSize,0,delVal),255,255);
    canvas.circle(sX*v.x,-sY*v.y,8);
    
  }
  
  /**
  * @param initial PVector's initial position (Starting)
  * @param output PVector's ending position (Ending)
  * Animates using an ease function the PVector moving to its output
  */
  public void moveVector(PVector initial, PVector output){ // check implementAV.png
    // To be implemented
  }
  
  public void run(PGraphics p){
    // To be implemented
  }
    
}
public class Easing {
    float easing;
    float incrementor;
    float change; //finalRotation in CP case
    float easeMultiplier = 1;
    
    public Easing(float c, float i, float e) { // Add incrementor constructor as well (for non 0 start!)
        change = c;
        incrementor = i;
        easing = e;
    }
    
    public Easing(float c, float i){
       change = c;
       incrementor = i;
       easing = 0.0004f;
    }
    
    public Easing(float c){
      change = c;
      incrementor = 0;
      easing = 0.0004f;
    }
    
    public void doStuff(){
      if (this.easing < 0.05f && !this.isEqual())
          this.multEase();
        
        
        if (!this.isEqual())
          this.incValue();
       

        if (this.isEqual())
          this.reset();
    }
    
    public boolean isEqual() {
        return abs(incrementor-change) < 0.01f;
    }

    /**
     *
     * @param stop
     * @return Linear interpolated value
     */
    public void incValue(){ // Make quadratic/polynomial later!
        incrementor = lerp(incrementor,change,easing);
    }

    /**
     *
     * @param ch
     * Set change to param
     */
    public void setChange(float ch) {
        change = ch;
    }

    /**
     * Reset easing to default value of 0.0004
     */
    public void reset() {
        easing = 0.0004f;
    }

    /**
     *
     * @param i Increase ease by multiplier "i"
     */
    public void incEase(float i){
       easeMultiplier = i;
        
    }
    
    public void multEase(){
       easing *= easeMultiplier;
    }
}
//import java.awt.Color;

public abstract class MObject {
  PVector pos;
  float width;
  float height;
  PGraphics canvas;
  float hue;
  
  public MObject(PGraphics c, float x, float y, float colHue){
    this(c,x,y,0,0,colHue);
  }
  
  public MObject(PGraphics c,float x, float y,float w, float h, float colHue) {
    pos = new PVector(x,y);
    width = w; 
    height = h;
    canvas = c;
    hue = colHue;
    //this.c = col;
  }
  
  public void backgroundRect(){ // work on this tom it is now tom
    canvas.noStroke();
    canvas.fill(0,0,0,125);
    if (canvas.textAlign == LEFT){
      canvas.rectMode(CORNER);
      canvas.rect(pos.x,pos.y-height+10,width,height);
    }
    else {
      canvas.rectMode(CENTER);
      canvas.rect(pos.x,pos.y+10,width,height);
    }
    
  }
  
  //rotate, translate, move, a lot more!
  
  public abstract void display(Object... obj);
}

public class TextMObject extends MObject {
  String str;
  float tSize;
  float transp = 0;
  public TextMObject(PGraphics c,String s, float x, float y, float size, float colHue){
    super(c,x,y,size*s.length()/2.2f,size,colHue);
    tSize = size;
    str = s;
  }
  
  public void display(Object... obj){
    this.backgroundRect();
    canvas.textSize(tSize);
    canvas.fill(hue,hue != 0 ? 255 : 0,255,map2(transp,0,255,0,255,QUADRATIC,EASE_IN));
    canvas.text(str,pos.x,pos.y);
    //map2(float value, float start1, float stop1, float start2, float stop2, int type, int when) {
   // println("NORMAL: " + map(transp,0,255,0,255) + " IMPROVED: " + map2(transp,0,255,0,255,QUADRATIC,EASE_IN));
    if (transp < 255)
      transp += 4;
      
  }
  
}
MObject tN;
public void setupNarrator(){
 tN = new TextMObject(canvas,"Hello there",-790,-320,70,0);
}



public void narration(){
  canvas.textAlign(LEFT);
  canvas.textSize(70);
  canvas.text("Sample text",-790,-420);
  tN.display();
}

public void afterNarration(){

}

public void narrate(){
  narration();
  afterNarration(); 
}

public void test(){
  println("I exist!");
}


public static class Useful {
  
  public static double floorAny(double jjfanman, double val){ // can only spit out integers... damn thsi!
    return  val*Math.floor(jjfanman/val);
}

  public static double ceilAny(double jjfanman, double val){
    return val*Math.ceil(jjfanman/val);
}
  
  public static String propFormat(float x){
    double eps =  round(x) / x;
    if (eps > 0.9f && eps < 1.1f)
      return Integer.toString(round(x));
     
     // assuming square roots!
     return "√" + Integer.toString(round(x*x));
  }
  
  /**
  *
  * Cycle through all colors of the rainbow
  */
  public static float getColor(float m,float lowerBound,float upperBound){
    return map(m,lowerBound,upperBound,0,255);
  }
    
  public static void rotatedText(String txt,PGraphics c, float x, float y, float theta){
    c.pushMatrix();
     
        c.translate(x,y); // where to place TXT?
      
        c.pushMatrix();
        
        if (theta < 0)
          theta += TAU;
        

       // println(theta);
         
          if (theta < 3*PI/2 && theta > PI/2){ //centBottom both does work, but it is a jarring experience!
             c.textAlign(CENTER,TOP);
             c.rotate(theta-PI);
          }
          else {
             c.textAlign(CENTER,BOTTOM);
             c.rotate(theta);
          }


          
          
        c.text(txt,0,0);
   c. popMatrix();
   
    c.popMatrix();
  }
  
}

/* The map2() function supports the following easing types */
final int LINEAR = 0;
final int QUADRATIC = 1;
final int CUBIC = 2;
final int QUARTIC = 3;
final int QUINTIC = 4;
final int SINUSOIDAL = 5;
final int EXPONENTIAL = 6;
final int CIRCULAR = 7;
final int SQRT = 8;

/* When the easing is applied (in, out, or both) */
final int EASE_IN = 0;
final int EASE_OUT = 1;
final int EASE_IN_OUT = 2;

/*
 * A map() replacement that allows for specifying easing curves
 * with arbitrary exponents.
 *
 * value :   The value to map
 * start1:   The lower limit of the input range
 * stop1 :   The upper limit of the input range
 * start2:   The lower limit of the output range
 * stop2 :   The upper limit of the output range
 * type  :   The type of easing (see above)
 * when  :   One of EASE_IN, EASE_OUT, or EASE_IN_OUT
 */
public float map2(float value, float start1, float stop1, float start2, float stop2, int type, int when) {
  float b = start2;
  float c = stop2 - start2;
  float t = value - start1;
  float d = stop1 - start1;
  float p = 0.5f;
  switch (type) {
  case LINEAR:
    return c*t/d + b;
  case SQRT:
    if (when == EASE_IN) {
      t /= d;
      return c*pow(t, p) + b;
    } else if (when == EASE_OUT) {
      t /= d;
      return c * (1 - pow(1 - t, p)) + b;
    } else if (when == EASE_IN_OUT) {
      t /= d/2;
      if (t < 1) return c/2*pow(t, p) + b;
      return c/2 * (2 - pow(2 - t, p)) + b;
    }
    break;
  case QUADRATIC:
    if (when == EASE_IN) {
      t /= d;
      return c*t*t + b;
    } else if (when == EASE_OUT) {
      t /= d;
      return -c * t*(t-2) + b;
    } else if (when == EASE_IN_OUT) {
      t /= d/2;
      if (t < 1) return c/2*t*t + b;
      t--;
      return -c/2 * (t*(t-2) - 1) + b;
    }
    break;
  case CUBIC:
    if (when == EASE_IN) {
      t /= d;
      return c*t*t*t + b;
    } else if (when == EASE_OUT) {
      t /= d;
      t--;
      return c*(t*t*t + 1) + b;
    } else if (when == EASE_IN_OUT) {
      t /= d/2;
      if (t < 1) return c/2*t*t*t + b;
      t -= 2;
      return c/2*(t*t*t + 2) + b;
    }
    break;
  case QUARTIC:
    if (when == EASE_IN) {
      t /= d;
      return c*t*t*t*t + b;
    } else if (when == EASE_OUT) {
      t /= d;
      t--;
      return -c * (t*t*t*t - 1) + b;
    } else if (when == EASE_IN_OUT) {
      t /= d/2;
      if (t < 1) return c/2*t*t*t*t + b;
      t -= 2;
      return -c/2 * (t*t*t*t - 2) + b;
    }
    break;
  case QUINTIC:
    if (when == EASE_IN) {
      t /= d;
      return c*t*t*t*t*t + b;
    } else if (when == EASE_OUT) {
      t /= d;
      t--;
      return c*(t*t*t*t*t + 1) + b;
    } else if (when == EASE_IN_OUT) {
      t /= d/2;
      if (t < 1) return c/2*t*t*t*t*t + b;
      t -= 2;
      return c/2*(t*t*t*t*t + 2) + b;
    }
    break;
  case SINUSOIDAL:
    if (when == EASE_IN) {
      return -c * cos(t/d * (PI/2)) + c + b;
    } else if (when == EASE_OUT) {
      return c * sin(t/d * (PI/2)) + b;
    } else if (when == EASE_IN_OUT) {
      return -c/2 * (cos(PI*t/d) - 1) + b;
    }
    break;
  case EXPONENTIAL:
    if (when == EASE_IN) {
      return c * pow( 2, 10 * (t/d - 1) ) + b;
    } else if (when == EASE_OUT) {
      return c * ( -pow( 2, -10 * t/d ) + 1 ) + b;
    } else if (when == EASE_IN_OUT) {
      t /= d/2;
      if (t < 1) return c/2 * pow( 2, 10 * (t - 1) ) + b;
      t--;
      return c/2 * ( -pow( 2, -10 * t) + 2 ) + b;
    }
    break;
  case CIRCULAR:
    if (when == EASE_IN) {
      t /= d;
      return -c * (sqrt(1 - t*t) - 1) + b;
    } else if (when == EASE_OUT) {
      t /= d;
      t--;
      return c * sqrt(1 - t*t) + b;
    } else if (when == EASE_IN_OUT) {
      t /= d/2;
      if (t < 1) return -c/2 * (sqrt(1 - t*t) - 1) + b;
      t -= 2;
      return c/2 * (sqrt(1 - t*t) + 1) + b;
    }
    break;
  };
  return 0;
}

/*
 * A map() replacement that allows for specifying easing curves
 * with arbitrary exponents.
 *
 * value :   The value to map
 * start1:   The lower limit of the input range
 * stop1 :   The upper limit of the input range
 * start2:   The lower limit of the output range
 * stop2 :   The upper limit of the output range
 * v     :   The exponent value (e.g., 0.5, 0.1, 0.3)
 * when  :   One of EASE_IN, EASE_OUT, or EASE_IN_OUT
 */
public float map3(float value, float start1, float stop1, float start2, float stop2, float v, int when) {
  float b = start2;
  float c = stop2 - start2;
  float t = value - start1;
  float d = stop1 - start1;
  float p = v;
  float out = 0;
  if (when == EASE_IN) {
    t /= d;
    out = c*pow(t, p) + b;
  } else if (when == EASE_OUT) {
    t /= d;
    out = c * (1 - pow(1 - t, p)) + b;
  } else if (when == EASE_IN_OUT) {
    t /= d/2;
    if (t < 1) return c/2*pow(t, p) + b;
    out = c/2 * (2 - pow(2 - t, p)) + b;
  }
  return out;
}
  public void settings() {  size(1920, 1080, P2D);  smooth(8); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#171717", "--stop-color=#cccccc", "planar" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

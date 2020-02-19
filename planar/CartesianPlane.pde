import processing.core.*;
import java.util.*;

public class CartesianPlane implements Plane { // Work on mouseDrag after!
    float xValue;
    float yValue;
    float transparency = 255;
    float sX;
    float sY;
    float startingX;
    float startingY;
    float scaleFactor = 0.06;
    float max = 0; //counter
    boolean restrictDomain = false;
    float restrictedDomainX1;
    float restrictedDomainX2;
    List<Double> randArr = new ArrayList<Double>();
    float finalValue;
    PGraphics canvas;
    
    /* Object initializations */  // Create color object soon for animateVector();
    List<PVector> points = new ArrayList<PVector>();
    Scaling scaler = new Scaling(0);
    Scaling fadeGraph = new Scaling();
    Easing slowRotate = new Easing(0);
    Easing animVector = new Easing(0); // change later
    Easing originTriangle = new Easing(0,12);
    Arrow traceGraphF = new Arrow(12,true);
    Arrow traceGraphG = new Arrow(12,true);
    /* Object initializations */
    
    
    /**
     *
     * @param xSpace Distance between x ticks
     * @param ySpace Distance between y ticks
     */
    public CartesianPlane(float xSpace, float ySpace,PGraphics p){
        xValue = xSpace;
        yValue = ySpace;
        sX = 200/xValue;
        sY = 200/yValue;
        canvas = p;
        startingX = Useful.floorAny(-canvas.width/(2*sX),xValue); // <---- Issues here when resizing canvas 
        startingY = Useful.floorAny(-canvas.height/(2*sY),yValue); // <---- Issues here when resizing canvas 
        max = -canvas.width/(2*sY) - xValue/5;
    }
    
    /**
     *
     * Creates a 2D Cartesian Plane with an x axis and a y axis
     */
    public void generatePlane(){
      
       canvas.beginDraw();
       
       canvas.background(0);
       canvas.textFont(myFont);
       canvas.textSize(38);
       canvas.textAlign(CENTER,CENTER);
       canvas.translate(canvas.width/2,canvas.height/2);
       canvas.stroke(122);
       canvas.strokeWeight(4);
       canvas.fill(190);
       
       
     //  pushMatrix();
       canvas.rotate(slowRotate.incrementor); //-PI/2
                
       for (float x = startingX; x < -startingX; x += xValue){
          if (x == 0) continue;
          canvas.line(sX*x,sY*startingY,sX*x,sY*-startingY);
  
        }
        
        
        for (float y = startingY; y < -startingY; y += yValue){
          if (y == 0) continue;
          canvas.line(-sX*startingX,sY*y,sX*startingX,sY*y);
         
        }
        
        canvas.stroke(255);
        canvas.strokeWeight(4);
        
        canvas.line(-sX*startingX,0,sX*startingX,0);
        canvas.line(0,-sY*startingY,0,sY*startingY);
        
     //   popMatrix();

        labelAxes();
        
    }
    
    /**
    * Label all axes
    */
    public void labelAxes(){
      canvas.fill(255);

      for (float x = startingX; x < -startingX; x += xValue){ //-width/(2*sX) - xValue/5 + xValue, starting 0,0 at width/2, height/2

            if (x == 0) continue;
            canvas.text(round(x),sX*(x + 0.5),30);
          }
          
      for (float y = startingY; y < -startingY; y += yValue){
          if (y == 0) continue;
          canvas.text(round(-y),-30,sY*(y-0.5));
        }

    }
    
    public void display(float x, float y){
      canvas.endDraw();
      //PImage frame = canvas.get(); Much more laggy!
      //pushMatrix();
      //translate(canvas.width/2,canvas.height/2);
      image(canvas,x,y);
     // popMatrix();
    }
    

    /**
     * Graph any function
     */
    public void graph(){
      canvas.strokeWeight(5);
      float sMax, endG;
      if (restrictDomain){
        sMax = restrictedDomainX1;
        endG = restrictedDomainX2;
      } else {
        sMax = startingX;
        endG = max;
      }
      
   //   loadRandArr();
      
      for (float i = startingX; i < max; i+=scaleFactor){
        if (i < sMax || i > endG){
           canvas.stroke(125,255,255,fadeGraph.fadeOut(0.01));
        } else
           canvas.stroke(getColor(i),255,255);
        
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
      
      traceGraphF.vector.set(max,f(max));
      traceGraphG.vector.set(max,g(max));
      drawVector(traceGraphF);
      drawVector(traceGraphG);
      
      if (max < -startingX) max+=0.05;
      
    // if (max > -0.88 && max < 0.88) max -= 0.044;
    //  println("x: " + max + " y: " + f(max));
      
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
      
      return x < 0 ? (float) (Math.random() * x - x) : (float) (0.4*Math.pow(x,cos(x)));
      //(float) (double) randArr.get((int) x + 25);
    }
    
   public float g(float x){
      return x < 0 ? -(float) (Math.random() * x - x): (float) -(0.4*Math.pow(x,sin(x/2)));
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
      slowRotate.incEase(1.045);
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
    *
    * Cycle through all colors of the rainbow
    */
    public float getColor(float m){
      return map(m,startingX,-startingX,0,255);
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
  public void drawVector(Arrow arrow){
    PVector v = arrow.vector; // aliases
    canvas.colorMode(HSB); 
    float triangleSize;
    canvas.pushMatrix();
    
    float c = getColor(max);
      
 // bundle PVector and Easing into one... This will be tough
     /*  if (max > -5){ // <--- boolean conditional
        originTriangle.incEase(1.045);
        originTriangle.doStuff();
      }
      
      if (max > 0)
        originTriangle.setChange(12);  */
        
      arrow.doStuff(1.045);
      
      
     // triangleSize = originTriangle.incrementor;
      // strokeWeight(originTriangle.incrementor * 10.0/12);
     
     triangleSize = arrow.incrementor;
     canvas.strokeWeight(arrow.incrementor * 10.0/12);


      float rotationAngle = v.heading();
      float magnitude = sX*v.mag() - 6; //arrow.vectorMag; // 6 works...?! apply ease to this v.mag() - 6

      canvas.stroke(c,255,255);
      canvas.fill(c,255,255);
      canvas.strokeCap(SQUARE);
      
      canvas.rotate(-rotationAngle);
      canvas.line(0,0,magnitude,0);
      canvas.triangle(magnitude-triangleSize*1.6,triangleSize,magnitude-triangleSize*1.6,-triangleSize,magnitude,0);
      
    canvas.popMatrix();
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

import processing.core.*;
import java.util.*;

public class CartesianPlane implements Plane {
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
    
    /* Object initializations */  // Create color object soon for animateVector();
    List<PVector> points = new ArrayList<PVector>();
    Scaling scaler = new Scaling(0);
    Scaling fadeGraph = new Scaling();
    Easing slowRotate = new Easing(0);
    Easing animVector = new Easing(0); // change later
    Easing originTriangle = new Easing(0,12);
    /* Object initializations */
    
    
    /**
     *
     * @param xSpace Distance between x ticks
     * @param ySpace Distance between y ticks
     */
    public CartesianPlane(float xSpace, float ySpace){
        xValue = xSpace;
        yValue = ySpace;
        sX = 200/xValue;
        sY = 200/yValue;
        startingX = -width/(2*sX) - xValue/5;
        startingY = -width/(2*sY) - yValue/5;
        max = startingX;
    }
    
    /**
     *
     * Creates a 2D Cartesian Plane with an x axis and a y axis
     */
    public void generatePlane(){
       background(0);
       textFont(myFont);
       textSize(38);
       textAlign(CENTER,CENTER);
       translate(width/2,height/2);
       stroke(122);
       strokeWeight(4);
       fill(190);
       
       
     //  pushMatrix();
       rotate(slowRotate.incrementor); //-PI/2
                
       for (float x = startingX; x < -startingX; x+= xValue){
          if (x == 0) continue;
          line(sX*x,sY*startingY,sX*x,sY*-startingY);
  
        }
        
        
        for (float y = startingY; y < -startingY; y += yValue){
          if (y == 0) continue;
          line(-sX*startingX,sY*y,sX*startingX,sY*y);
         
        }
        
        stroke(255);
        strokeWeight(4);
        
        line(-sX*startingX,0,sX*startingX,0);
        line(0,-sY*startingY,0,sY*startingY);
        
     //   popMatrix();

        labelAxes();
        
    }
    
    /**
    * Label all axes
    */
    public void labelAxes(){
      fill(255);

      for (float x = startingX; x < -startingX; x += xValue){ //-width/(2*sX) - xValue/5 + xValue, starting 0,0 at width/2, height/2

            if (x == 0) continue;
            text(round(x),sX*(x + 0.5),30);
          }
          
      for (float y = startingY; y < -startingY; y += yValue){
          if (y == 0) continue;
          text(round(y),-30,sY*(y-0.5));
        }

    }

    /**
     * Graph any function
     */
    public void graph(){
      strokeWeight(5);
      float sMax, endG;
      if (restrictDomain){
        sMax = restrictedDomainX1;
        endG = restrictedDomainX2;
      } else {
        sMax = startingX;
        endG = max;
      }
      
      for (float i = startingX; i < max; i+=scaleFactor){
        if (i < sMax || i > endG){
           stroke(125,255,255,fadeGraph.fadeOut(0.01));
        } else
           stroke(getColor(i),255,255);
        
        line(sX*i,-sY*f(i),sX*(i+scaleFactor),-sY*(f(i+scaleFactor)));
        

      }
      
      drawVector(new PVector(max,f(max)),true);
      
      if (max < -startingX) max+=0.05;
      
   //  if (max > -0.33 && max < 0.33) max -= 0.044;
    //  println("x: " + max + " y: " + f(max));
      
    }

    /**
     *
     * @param x Input to the function (x-coord)
     * @return Output to the function (y-coord)
     */
    public float f(float x){
      return sin(x);
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
    
    public float g(float x){
      return cos(x);
    }
    
    /**
    * Get derivative given two values
    */
    public void derivative(float y1, float y2, float distX){
      stroke(255);
      line(sX*(max+2),sY*y1,sX*(max-2),sY*y2);
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

      stroke(255,scaler.fadeIn(9));
      fill(255,scaler.getTransp());
      circle(x,y,20);
  }
  
  /**
  * @param v Vector to be drawn
  * Draws vector in Cartesian Space
  */
  public void drawVector(PVector v, boolean graphDependent){
    colorMode(HSB); 
    float triangleSize;
    pushMatrix();
      float c = getColor(max);
      
    if (graphDependent){ // bundle PVector and Easing into one... This will be tough
      if (max > -5){
        originTriangle.incEase(1.045);
        originTriangle.doStuff();
      }
      
      if (max > 0)
        originTriangle.setChange(12);
      
      
      triangleSize = originTriangle.incrementor;
      strokeWeight(originTriangle.incrementor * 10.0/12);
    } else {
      triangleSize = 12;
      strokeWeight(10);
    }

      float rotationAngle = v.heading();
      float magnitude = sX*v.mag() - 6; // 6 works...?! apply ease to this
      stroke(c,255,255);
      fill(c,255,255);
      strokeCap(SQUARE);

      rotate(-rotationAngle);
      line(0,0,magnitude,0);
      triangle(magnitude-triangleSize*1.6,triangleSize,magnitude-triangleSize*1.6,-triangleSize,magnitude,0);
      
    popMatrix();
  }
  
  /**
  * @param initial PVector's initial position (Starting)
  * @param output PVector's ending position (Ending)
  * Animates using an ease function the PVector moving to its output
  */
  public void animateVector(PVector initial, PVector output){ // check implementAV.png
    // To be implemented
  }
    
}

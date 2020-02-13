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
    float max = 0;
    float easing = 0.0004;
    float rotation = 0;
    boolean restrictDomain = false;
    float restrictedDomainX1;
    float restrictedDomainX2;
    
      int state = 0;
      int a = 255;
      int r = 255;
      int g = 0;
      int b = 0;
    
    List<PVector> points = new ArrayList<PVector>();
    Scaling scaler = new Scaling(0);
    Scaling fadeGraph = new Scaling();

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
       rotate(rotation); //-PI/2
                
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
           stroke(125,255,65,fadeGraph.fadeOut(0.01));
        } else
           stroke(125,255,65);
        
        line(sX*i,-sY*f(i),sX*(i+scaleFactor),-sY*(f(i+scaleFactor)));
        

      }

      if (max < -startingX) max += scaleFactor;
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
      
      if (easing < 0.05 && abs(rotation-theta) >= 0.01){
          easing *= 1.045; 
        }
        
        if (abs(rotation-theta) >= 0.01)
          rotation = lerp(rotation,theta,easing);
       

        if (abs(rotation-theta) < 0.01){
          easing = 0.0004;
        }

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
    public int getHexColor(){
      
      if(state == 0){
          g++;
          if(g == 255)
              state = 1;
      }
      if(state == 1){
          r--;
          if(r == 0)
              state = 2;
      }
      if(state == 2){
          b++;
          if(b == 255)
              state = 3;
      }
      if(state == 3){
          g--;
          if(g == 0)
              state = 4;
      }
      if(state == 4){
          r++;
          if(r == 255)
              state = 5;
      }
      if(state == 5){
          b--;
          if(b == 0)
              state = 0;
      }
      return (a << 24) + (r << 16) + (g << 8) + (b);

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
  public void drawVector(PVector v){

    pushMatrix();
      
      float triangleSize = 8;
      float magnitude = sX*v.mag() - 20; // 20 is a constant, figure out why it does not work with abstraction
      stroke(getHexColor());
      strokeCap(SQUARE);
      strokeWeight(10);
      rotate(-v.heading());
      line(0,0,magnitude,0);
      triangle(magnitude,triangleSize,magnitude,-triangleSize,magnitude+triangleSize*1.6,0);
      
    popMatrix();
  }
  
  /**
  * @param initial PVector's initial position (Starting)
  * @param output PVector's ending position (Ending)
  * Animates using an ease function the PVector moving to its output
  */
  public void animateVector(PVector initial, PVector output){
    // To be implemented
  }
    
}

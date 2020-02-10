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
    float[] rgbColors = {255.0f,0,0};
    float finalRotation = 0;
    float easing = 0.0004;
    float rotation = 0;
    boolean restrictDomain = false;
    float restrictedDomainX1;
    float restrictedDomainX2;
    
    List<PVector> points = new ArrayList<PVector>();
    Scaling scaler = new Scaling(0);
    Scaling fadeGraph = new Scaling();
    
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
        fill(190);
        
        // Rotation
     //   pushMatrix();
        if (easing < 0.05 && abs(rotation-finalRotation) >= 0.01){
        //  println("e: " + easing + " cR " + rotation + " fr: " + finalRotation);
          easing *= 1.045; 
        }
        
        if (abs(rotation-finalRotation) >= 0.01)
          rotation = lerp(rotation,finalRotation,easing);
       

        if (abs(rotation-finalRotation) < 0.01){
          easing = 0.0004;
        }
        //rotation = map(rotation,rotation,finalRotation,rotation,finalRotation);
      //  println(rotation);

        rotate(rotation);
          
        for (float x = startingX; x < -startingX; x+= xValue){
          if (x == 0) continue;
          line(sX*x,sY*startingY,sX*x,sY*-startingY);
  
        }
        
        
         for (float y = startingY; y < -startingY; y += yValue){
          if (y == 0) continue;
          line(-sX*startingX,sY*y,sX*startingX,sY*y);
         
        }
     //   popMatrix();
        
        labelAxes();
        
        stroke(255);
        strokeWeight(4);
        line(-sX*startingX,0,sX*startingX,0);
        line(0,-sY*startingY,0,sY*startingY);
        
        
    }
    
    /**
    * Label all axes
    */
    public void labelAxes(){
      fill(255);
      
    for (float x = startingX; x < -startingX; x+= xValue){
          if (x == 0) continue;
          text(round(x),sX*(x + 0.5),30);
        }
        
          for (float y = startingY; y < -startingY; y += yValue){
          if (y == 0) continue;
          text(round(y),-30,sY*(y-0.5));
        }
        
    }
    
    
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
        
       // stroke(255,65,125);
      //  line(sX*i,-sY*g(i),sX*(i+scaleFactor),-sY*(g(i+scaleFactor)));
      }

      if (max < -startingX) max += scaleFactor;
    }
    
    public float f(float x){
      return sin(x);
    }
    
    public void restrictDomain(float x1, float x2){
      restrictedDomainX1 = x1;
      restrictedDomainX2 = x2;
      restrictDomain = true;
    }
    
    public void rotatePlane(float theta){
      finalRotation = theta;
    }
    
    public float g(float x){
      return cos(x);
    }
    
    /**
    * get derivative
    */
    public void derivative(float y1, float y2, float distX){
      stroke(255);
      line(sX*(max+2),sY*y1,sX*(max-2),sY*y2);
    }
    
    public void autoscale(){
    }
    
    public void createPoint(float x, float y){
      points.add(new PVector(x,y));

      stroke(255,scaler.fadeIn(9));
      fill(255,scaler.getTransp());
      circle(x,y,20);
  }
    
}

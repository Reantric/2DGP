import processing.core.*;
import java.util.*;

public class cp implements Plane {
    double xValue;
    double yValue;
    float transparency = 255;
    boolean isGone = false;
    List<PVector> points = new ArrayList<PVector>();
    Scaling scaler = new Scaling(0);
    
    /**
     *
     * @param xSpace x dist
     * @param ySpace y dist
     * Creates a 2D Cartesian Plane with an x axis and a y axis
     */
    public void generatePlane(float xSpace, float ySpace){
      //  pushMatrix();
        xValue = xSpace;
        yValue = ySpace;
     //   translate(width/2);
      //  popMatrix();
    }
    
    public void autoscale(){
    }
    
    public void createPoint(float x, float y){
      points.add(new PVector(x,y));

  //    stroke(255,scaler.fadeIn(2));
  //    fill(255,scaler.getTransp());
     // circle(x,y,20);
  }
    
}

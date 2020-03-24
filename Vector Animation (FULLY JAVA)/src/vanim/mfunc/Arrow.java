package vanim.mfunc;

import vanim.misc.*;
import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PVector;

import java.util.ArrayList;
import java.util.List;

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
        coords = new ArrayList<>();
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
        if (angle < 0) angle = PApplet.TAU + vector.heading();
        c.noFill();
        c.stroke(255);
        //  println(angle);
        c.arc(0, 0, 60, 60, -angle%PApplet.TAU+ PApplet.radians(0.2f), PApplet.radians(0.2f));
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
            planar.println("is this ever happening?");
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
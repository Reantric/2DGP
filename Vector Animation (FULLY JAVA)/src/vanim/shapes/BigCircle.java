package vanim.shapes;
import java.util.*;
import processing.core.*;
import vanim.planar;
import vanim.misc.Useful;

public class BigCircle extends MObject{
    List<float[]> coords;
    int coordsSize = 0;
    float incrementor;
    float speed;
    int delVal, optimalDelVal;

    public BigCircle(PGraphics c, float x, float y, float radius,float speed, int delVal){
        super(c,x,y,radius,0); // will fix!
        this.speed = speed;
        incrementor = 0;
        this.delVal = delVal;
        coords = new ArrayList<>();
    }

   /* public void addPoint(float x, float y){
        coords.add(new float[]{x,y});
        coordsSize++;
        // println(coordsSize);
    } */

    public void addPoint(){
        if (coordsSize < delVal){
            coords.add(new float[]{width * PApplet.cos(incrementor), -height * PApplet.sin(incrementor)});
            coordsSize++;
        }
        // println(coordsSize);
    }

    public void graph(){
    /* float epsX = (coords.get(coordsSize-1)[0]+0.001)/(coords.get(0)[0]+0.001); //buffer
    float epsY = (coords.get(coordsSize-1)[1]+0.001)/(coords.get(0)[1]+0.001); //buffer */

        boolean epsX = coords.get(0)[0]/coords.get(coordsSize-1)[0] > 0.99f && coords.get(0)[0]/coords.get(coordsSize-1)[0] < 1.01f; // x does not start/end at 0 !
        boolean epsY = coordsSize > 1 && coords.get(coordsSize-2)[1] > coords.get(0)[1] && coords.get(coordsSize-1)[1] <= coords.get(0)[1];

        //  if (coordsSize > 1)
        //  println(String.format("%f < %f && %f >= %f",coords.get(coordsSize-2)[0],coords.get(0)[0],coords.get(coordsSize-1)[0],coords.get(0)[0]));

        // println(coords.get(0)[0]/coords.get(coordsSize-1)[0]);
        if (epsX && epsY){
            optimalDelVal = coordsSize;
           //  PApplet.println("Optimal delVal: " + optimalDelVal); <-- reenable
            //    stop();
        }

        if (coordsSize > delVal){
            planar.println("is this ever happening?");
            coords.remove(0);
            coordsSize--;
        }

        for (int i = 0; i < coordsSize-1; i++){
            canvas.stroke(Useful.getColor(i,0,delVal),255,255);
            canvas.strokeWeight(5);
            canvas.line(coords.get(i)[0],coords.get(i)[1],coords.get(i+1)[0],coords.get(i+1)[1]);
        }
    }

    public void display(Object... obj){
        addPoint();
        graph();
        incrementor += speed;
    }



}
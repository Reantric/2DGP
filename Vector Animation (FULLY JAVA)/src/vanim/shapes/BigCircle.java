package vanim.shapes;

import vanim.misc.*;
import static vanim.planar.*;
import java.util.*;
import processing.core.*;




public class BigCircle extends MObject{
    List<float[]> coords;
    int coordsSize = 0;
    float incrementor;
    float speed;
    int delVal, optimalDelVal;
    float distance;
    Line dy;

    public BigCircle(PGraphics c, float x, float y, float radius,float speed, int delVal){
        super(c,x,y,radius,0); // will fix!
        this.speed = speed;
        incrementor = 0;
        this.delVal = delVal;
        coords = new ArrayList<>();
        //PGraphics c, float x1, float y1, float x2, float y2, float weight, float colHue
        dy = new Line(c,0,radius,0,radius,9,0);
        distance = radius*1.8f;
         // radius --> 400
    }

   /* public void addPoint(float x, float y){
        coords.add(new float[]{x,y});
        coordsSize++;
        // println(coordsSize);
    } */

    public boolean addPoint(){
        if (coordsSize < delVal){
            coords.add(new float[]{width * cos(incrementor), -height * sin(incrementor)});
            coordsSize++;
        }
        return true;
        // println(coordsSize);
    }

    public boolean drawTangentLine(float x, float y){
        x *= 1.007f;
        y *= 1.007f;
        float newDist = Mapper.map2(incrementor,0,distance,0,distance,Mapper.QUADRATIC,Mapper.EASE_IN);
        if (newDist > distance)
            newDist = distance;
        float common = newDist/(2*sqrt(1+(plane.sX*x*plane.sX*x) / (plane.sY*y*plane.sY*y)));

        float x1 = common + x*width;
        float y1 = (-x/y) * common + y*width;
        float x2 = -common + x*width;
        float y2 = (x/y) * common + y*width;
        //PGraphics c, float x1, float y1, float x2, float y2, float weight, float colHue
        canvas.strokeWeight(5.7f);
       // canvas.colorMode(HSB);
        canvas.stroke(30,255,255);
        canvas.line(x1,y1,x2,y2);
      /*  dy.setStart(x1/plane.sX,y1/plane.sY);
        dy.setFinal(x2/plane.sX,y2/plane.sY);
        dy.setStrokeCap(PROJECT);
        dy.display(); */
        incrementor += distance/50.0f;
        return common == distance;
    }

    public boolean graph(){
    /* float epsX = (coords.get(coordsSize-1)[0]+0.001)/(coords.get(0)[0]+0.001); //buffer
    float epsY = (coords.get(coordsSize-1)[1]+0.001)/(coords.get(0)[1]+0.001); //buffer */

        boolean epsX = coords.get(0)[0]/coords.get(coordsSize-1)[0] > 0.99f && coords.get(0)[0]/coords.get(coordsSize-1)[0] < 1.01f; // x does not start/end at 0 !
        boolean epsY = coordsSize > 1 && coords.get(coordsSize-2)[1] > coords.get(0)[1] && coords.get(coordsSize-1)[1] <= coords.get(0)[1];

        //  if (coordsSize > 1)
        //  println(String.format("%f < %f && %f >= %f",coords.get(coordsSize-2)[0],coords.get(0)[0],coords.get(coordsSize-1)[0],coords.get(0)[0]));

        // println(coords.get(0)[0]/coords.get(coordsSize-1)[0]);
        if (epsX && epsY){
            optimalDelVal = coordsSize;
           //  println("Optimal delVal: " + optimalDelVal); <-- reenable
            //    stop();
        }

        if (coordsSize > delVal){
            println("is this ever happening?");
            coords.remove(0);
            coordsSize--;
        }

        for (int i = 0; i < coordsSize-1; i++){
            canvas.stroke(Useful.getColor(i,0,delVal),255,255);
            canvas.strokeWeight(5);
            canvas.line(coords.get(i)[0],coords.get(i)[1],coords.get(i+1)[0],coords.get(i+1)[1]);
        }

        return coordsSize == delVal;
    }

    public boolean display(Object... obj){
        addPoint();
        boolean b = graph();
        incrementor += speed;
        return b;
    }



}
package vanim.shapes;

import vanim.misc.*;
import static vanim.planar.*;
import java.util.*;
import processing.core.*;




public class Circle extends Ellipse{
    //public Ellipse(PGraphics c,float x, float y, float xAxis, float yAxis,float speed, int delVal){
    public Circle(PGraphics c, float x, float y, float radius,float speed, int delVal){
        super(c,x,y,radius,radius,speed,delVal);
    }

    /* public boolean drawTangentLine(float x, float y){
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
        canvas.stroke(30,255,255);
        canvas.line(x1,y1,x2,y2);
        incrementor += distance/50.0f;
        return newDist/distance > 0.99 && newDist/distance < 1.01;
    } */

    @Override
    public boolean scale(float... obj) {
        return false;
    }



}
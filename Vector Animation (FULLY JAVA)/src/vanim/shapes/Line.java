package vanim.shapes;
import vanim.misc.*;
import processing.core.*;
import vanim.planar;

import static vanim.planar.*;
import static vanim.misc.Mapper.*;

public class Line extends MObject {

    float weight;
    float finalX, finalY, amtPushX, amtPushY;
    float startX, startY;
    int strokeNum;
    float incX, incY;


    public Line(PApplet p, PGraphics c, float x1, float y1, float x2, float y2){
        this(p,c, x1, y1, x2,y2,7,255);
    }

    public Line(PGraphics c, float x1, float y1, float x2, float y2){
        this(null,c,x1,y1,x2,y2,5,255);
    }

    public Line(PGraphics c, float x1, float y1, float x2, float y2, float weight, float colHue){
        this(null,c,x1,y1,x2,y2,weight,colHue);
    }
    public Line(PApplet p,PGraphics c, float x1, float y1, float x2, float y2, float weight, float colHue) { //p not used here...
        super(p,c, x1, y1, colHue);
        this.weight = weight;
        finalX = x2;
        finalY = y2;
        startY = pos.y;
        startX = pos.x;
        incX = 0;
        incY = 0;
        println("BEGINNING: " + pos.x);
    }


    public void setFinal(float x, float y) {
        finalX = x;
        finalY = y;
    }

    public void setStrokeCap(int WHAT){
        strokeNum = WHAT;
    }

    public void setStart(float x, float y) {
        startX = x;
        startY = y;
    }

    //float value, float start1, float stop1, float start2, float stop2, int type, int when
    public void push() {
        amtPushX = (finalX - startX) / 50.0f;
        amtPushY = (finalY - startY) / 50.0f;

        if (abs(pos.x) < abs(finalX)) {
            incX += amtPushX;
            pos.x = map2(incX, startX, finalX, startX, finalX, QUADRATIC, EASE_IN_OUT);
        }

        if (abs(pos.y) < abs(finalY)) {
            incY += amtPushY;
            pos.y = map2(incY, startY, finalY, startY, finalY, QUADRATIC, EASE_IN_OUT);
        }

        println("x1: " + pos.x + " y1: " + pos.y);

        if (abs(pos.x) > abs(finalX))
            pos.x = finalX;


        if (abs(pos.y) > abs(finalY))
            pos.y = finalY;

       // println("x2: " + pos.x + " y2: " + pos.y);
    }


    public boolean display(Object... obj) {
        canvas.strokeCap(strokeNum);
        push();
        if (weight != 0)
            canvas.strokeWeight(weight);

        canvas.stroke(hue, hue == 255 ? 0 : 255, 255);
        canvas.line(startX, startY, pos.x, pos.y);
        return pos.x == finalX && pos.y == finalY;
    }
}
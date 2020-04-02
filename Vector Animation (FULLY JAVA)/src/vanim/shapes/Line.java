package vanim.shapes;
import vanim.misc.*;
import processing.core.*;
import vanim.planar;

import javax.swing.*;

import static vanim.planar.*;
import static vanim.misc.Mapper.*;

public class Line extends MObject {

    float weight;
    float finalX, finalY, amtPushX, amtPushY;
    float startX, startY;
    int strokeNum;
    float incX, incY;

    public Line(PApplet p, PGraphics c, float x1, float y1, float x2, float y2){
        this(p,c, x1, y1, x2,y2,4,255,255,255);
    }

    public Line(PGraphics c, float x1, float y1, float x2, float y2){
        this(null,c,x1,y1,x2,y2,4,255,255,255);
    }

    public Line(PGraphics c, float x1, float y1, float x2, float y2, float weight, float colHue){
        this(null,c,x1,y1,x2,y2,weight,colHue,255,255);
    }


    public Line(PApplet p,PGraphics c, float x1, float y1, float x2, float y2, float weight, float colHue, float colSat, float colBright) { //p not used here...
        super(p,c, x1, y1, 0,colHue,colSat,colBright);
        this.weight = weight;
        finalX = x2;
        finalY = y2;
        startY = pos.y;
        startX = pos.x;
        incX = 0;
        incY = 0;
       // println("BEGINNING: " + pos.x);
    }


    public void setFinal(float x, float y) {
        finalX = x;
        finalY = y;
    }

    public void setStrokeCap(int WHAT){
        strokeNum = WHAT;
    }

    public void setMapPower(float jj){
        mapPower = jj;
    }
    public void setStart(float x, float y) {
        startX = x;
        startY = y;
    }

    //float value, float start1, float stop1, float start2, float stop2, int type, int when
    public void push(float dividend) {
        amtPushX = (finalX - startX) / dividend;
        amtPushY = (finalY - startY) / dividend;

        if (amtPushX > 0) {
            if (pos.x < finalX) {
                incX += amtPushX;
                pos.x = map3(incX, startX, finalX, startX, finalX, mapPower, EASE_IN_OUT);
            }
            if (pos.x > finalX)
                pos.x = finalX;
        }

        else {
            if (pos.x > finalX) {
                incX += amtPushX;
                pos.x = map3(incX, startX, finalX, startX, finalX, mapPower, EASE_IN_OUT);
            }
            if (pos.x < finalX)
                pos.x = finalX;
        }

        if (amtPushY > 0){
            if (pos.y < finalY){
                incY += amtPushY;
                pos.y = map3(incY, startY, finalY, startY, finalY, mapPower, EASE_IN_OUT);
            }
            if (pos.y > finalY)
                pos.y = finalY;
        } else {
            if (pos.y > finalY){
                incY += amtPushY;
                pos.y = map3(incY, startY, finalY, startY, finalY, mapPower, EASE_IN_OUT);
            }
            if (pos.y < finalY)
                pos.y = finalY;
        }


        //println("x1: " + pos.x + " y1: " + pos.y);
       // println("x2: " + pos.x + " y2: " + pos.y);
    }


    public boolean display(Object... obj) {
        canvas.strokeCap(strokeNum);
        push(50);
        if (weight != 0)
            canvas.strokeWeight(weight);

        canvas.stroke(hue, hue == 255 ? 0 : 255, 255);
        canvas.line(startX, startY, pos.x, pos.y);
        return pos.x == finalX && pos.y == finalY;
    }
}
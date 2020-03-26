package vanim.shapes;
import vanim.misc.*;
import processing.core.*;
import static vanim.planar.*;
import static vanim.misc.Mapper.*;

public class Line extends MObject {

    float weight;
    float finalX, finalY, amtPushX, amtPushY;
    float startX, startY;
    int strokeNum;
    float incX, incY;

    public Line(PGraphics c, float x1, float y1, float x2, float y2, float weight, float colHue) {
        super(c, plane.sX*x1, plane.sY*y1, colHue);
        this.weight = weight;
        finalX = plane.sX * x2;
        finalY = plane.sY * y2;
        startY = plane.sY * pos.y;
        startX = plane.sX * pos.x;
        amtPushX = (finalY - startY) / 100.0f;
        amtPushY = (finalY - startY) / 100.0f;
        incX = 0;
        incY = 0;
    }

    public void setFinal(float x, float y) {
        finalX = plane.sX * x;
        finalY = plane.sY * y;
    }

    public void setStrokeCap(int WHAT){
        strokeNum = WHAT;
    }

    public void setStart(float x, float y) {
        startX = plane.sX * x;
        startY = plane.sY * y;
    }

    //float value, float start1, float stop1, float start2, float stop2, int type, int when
    public void push() {
        amtPushX = (finalX - startX) / 50.0f;
        amtPushY = (finalY - startY) / 50.0f;

        if (pos.x < finalX) {
            incX += amtPushX;
            pos.x = map3(incX, startX, finalX, startX, finalX, 1.6f, EASE_IN_OUT);
        }

        if (pos.y < finalY) {
            incY += amtPushY;
            pos.y = map3(incY, startY, finalY, startY, finalY, 1.6f, EASE_IN_OUT);
        }


        if (pos.x > finalX || Float.isNaN(pos.x))
            pos.x = finalX;


        if (pos.y > finalY || Float.isNaN(pos.y))
            pos.y = finalY;


      //  println(pos.x);

        // println("AFTER " + finalX);


    }


    public boolean display(Object... obj) {
        canvas.strokeCap(strokeNum);
        push();
        if (weight != 0)
            canvas.strokeWeight(weight);

        canvas.stroke(hue, 255, 255);
        canvas.line(startX, startY, pos.x, pos.y);
        return pos.x == finalX && pos.y == finalY;
    }
}
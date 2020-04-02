package vanim.shapes;

import processing.core.PApplet;
import processing.core.PGraphics;

public class DoubleLine extends Line{

    float xAverage;
    float yAverage;

    public DoubleLine(PApplet p, PGraphics c, float x1, float y1, float x2, float y2, float weight,float colHue, float colSat, float colBright) {
            super(p, c, x1, y1, x2, y2,weight,colHue,colSat,colBright);
            xAverage = (startX + finalX)/2.0f;
            yAverage = (startY + finalY)/2.0f;
        }


    public DoubleLine(PGraphics c, float x1, float y1, float x2, float y2) {
        this(null,c,x1,y1,x2,y2,4,255,255,255);
    }

    public DoubleLine(PGraphics c, float x1, float y1, float x2, float y2, float weight) {
        this(null,c,x1,y1,x2,y2,weight,255,255,255);
    }

    public DoubleLine(PGraphics canvas, float x1, float y1, float x2, float y2, float weight, int colHue, int colSat, int colBright) {
        this(null,canvas,x1,y1,x2,y2,weight,colHue,colSat,colBright);
    }

    // public DoubleLine(PGraphics canvas, float v, float v1, float v2, float v3, float v4, int i, int i1) {
 //       super();
   // }

    @Override
    public boolean display(Object... obj){
        canvas.fill(hue,sat,bri);
        canvas.strokeCap(strokeNum);
        setMapPower(3);
        push(100);
        if (weight != 0)
            canvas.strokeWeight(weight);


        canvas.line(xAverage,yAverage,pos.x,pos.y);
        canvas.line(xAverage,yAverage,2*xAverage - pos.x,2*yAverage - pos.y);

        return pos.x == finalX && pos.y == finalY;
    }
}

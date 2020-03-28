package vanim.shapes;

import processing.core.PApplet;
import processing.core.PGraphics;

public class DoubleLine extends Line{

    float xAverage;
    float yAverage;

    public DoubleLine(PApplet p, PGraphics c, float x1, float y1, float x2, float y2, float weight) {
            super(p, c, x1, y1, x2, y2,weight,255);
            xAverage = (startX + finalX)/2.0f;
            yAverage = (startY + finalY)/2.0f;
        }


    public DoubleLine(PGraphics c, float x1, float y1, float x2, float y2) {
        this(null,c,x1,y1,x2,y2,4);
    }

    public DoubleLine(PGraphics c, float x1, float y1, float x2, float y2, float weight) {
        this(null,c,x1,y1,x2,y2,weight);
    }

    @Override
    public boolean display(Object... obj){
        canvas.strokeCap(strokeNum);
        push();
        if (weight != 0)
            canvas.strokeWeight(weight);

        canvas.stroke(hue, hue == 255 ? 0 : 255, 255);
        canvas.line(xAverage,yAverage, pos.x, pos.y);
        canvas.line(xAverage, yAverage, -pos.x, -pos.y);
        return pos.x == finalX && pos.y == finalY;
    }
}

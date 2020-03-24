package vanim.shapes;
import vanim.misc.*;
import processing.core.*;

public class Line extends MObject{

    float weight;
    float finalX, finalY, amtPushX, amtPushY;
    float startX, startY;

    public Line(PGraphics c, float x1, float y1, float x2, float y2, float weight, float colHue) {
        super(c, x1, y1, colHue);
        this.weight = weight;
        finalX = x2;
        finalY = y2;
        startY = pos.y;
        startX = pos.x;
        amtPushX = (finalX - pos.x)/100.0f;
        amtPushY = (finalY - pos.y)/100.0f;
    }

    public void setFinal(float x, float y){
        finalX = x;
        finalY = y;
    }
    //float value, float start1, float stop1, float start2, float stop2, int type, int when
    public void push(){
        amtPushX = (finalX - startX)/100.0f;
        amtPushY = (finalY - startY)/100.0f;
        pos.x = Mapper.map2(pos.x + amtPushX,startX,finalX,startX,finalX,Mapper.QUADRATIC,Mapper.EASE_IN);
        pos.y = Mapper.map2(pos.y + amtPushY,startY,finalY,startY,finalY,Mapper.QUADRATIC,Mapper.EASE_IN);
        System.out.println(pos.x);
    }

    @Override
    public void display(Object... obj) {
        push();
        if (weight != 0)
            canvas.strokeWeight(weight);

        canvas.stroke(hue);
        canvas.line(startX,startY,pos.x,pos.y);
    }
}

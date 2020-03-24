
public class Line extends MObject{

    float weight;
    float finalX, finalY, amtPushX, amtPushY;
    float startX, startY;
    
    float incX, incY;

    public Line(PGraphics c, float x1, float y1, float x2, float y2, float weight, float colHue) {
        super(c, plane.sX*x1, plane.sY*y1, colHue);
        this.weight = weight;
        finalX = plane.sX*x2;
        finalY = plane.sY*y2;
        startY = plane.sY*pos.y;
        startX = plane.sX*pos.x;
        amtPushX = (finalX - startY)/100.0f;
        amtPushY = (finalY - startX)/100.0f;
        incX = 0;
        incY = 0;
    }

    public void setFinal(float x, float y){
        finalX = plane.sX*x;
        finalY = plane.sY*y;
    }
    //float value, float start1, float stop1, float start2, float stop2, int type, int when
    public void push(){
        amtPushX = (finalX - startX)/100.0f;
        amtPushY = (finalY - startY)/100.0f;
        //amtPushX = 1;
        //amtPushY = 1;
        if (pos.x < finalX){
            incX += amtPushX;
            pos.x = map2(incX,startX,finalX,startX,finalX,QUADRATIC,EASE_IN);
        } else {
          pos.x = finalX;
        }
        
        if (pos.y < finalY){
          incY += amtPushY;
          pos.y = map2(incY,startY,finalY,startY,finalY,QUADRATIC,EASE_IN);
        } else {
          pos.y = finalY;
        }

        println("BEFORE: " + startX);
        
        println("AFTER " + finalX);
        
        pos.set(finalX,finalY);
    }


    public void display(Object... obj) {
        push();
        if (weight != 0)
            canvas.strokeWeight(weight);

        canvas.stroke(hue);
        canvas.line(startX,startY,pos.x,pos.y);
    }
}

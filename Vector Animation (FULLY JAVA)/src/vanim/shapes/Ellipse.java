package vanim.shapes;
import processing.core.*;
import vanim.misc.Mapper;
import vanim.misc.Useful;
import java.util.ArrayList;
import java.util.List;
import static processing.core.PApplet.*;
import static vanim.planar.*;

public class Ellipse extends VObject {
    List<float[]> coords = new ArrayList<>();
    int coordsSize = 0;
    float incrementor = 0;
    float speed;
    int delVal, optimalDelVal;
    float distance;
    Line dy;

    public Ellipse(PGraphics c,float x, float y, float xAxis, float yAxis,float speed, int delVal){
        super(c,x,y,xAxis*plane.sX,yAxis*plane.sY,0,255,255);
        this.delVal = delVal;
        this.speed = speed;
        distance = (plane.sY*yAxis + plane.sX*xAxis)*0.9f;
    }

    public void addPoint(){
        if (coordsSize < delVal){
            coords.add(new float[]{width * cos(incrementor), -height * sin(incrementor)});
            coordsSize++;
        }
    }

    public boolean drawTangentLine(float x, float y){
        x *= 1.007f;
        y *= 1.007f;
        float newDist = Mapper.map2(incrementor,0,distance,0,distance,Mapper.QUADRATIC,Mapper.EASE_IN);
        if (newDist > distance)
            newDist = distance;
        float common = newDist/(2*sqrt((float) (1+(Math.pow(height,4)* plane.sX*x*plane.sX*x) / (Math.pow(width,4) * plane.sY*y*plane.sY*y))));

        float x1 = common + x*plane.sX;
        float y1 = (-x*height*height)/(y*width*width) * common + y*plane.sY;
        float x2 = -common + x*plane.sX;
        float y2 = (x*height*height)/(y*width*width) * common + y*plane.sY;
        //PGraphics c, float x1, float y1, float x2, float y2, float weight, float colHue
        canvas.strokeWeight(5.7f);
        canvas.stroke(30,255,255);
        canvas.line(x1,y1,x2,y2);
        incrementor += distance/50.0f;
        return newDist/distance > 0.99 && newDist/distance < 1.01;
    }

    public boolean graph(){

        //Works for all closed shapes
        boolean epsX = coords.get(0)[0]/coords.get(coordsSize-1)[0] > 0.99f && coords.get(0)[0]/coords.get(coordsSize-1)[0] < 1.01f; // x does not start/end at 0 !
        boolean epsY = coordsSize > 1 && coords.get(coordsSize-2)[1] > coords.get(0)[1] && coords.get(coordsSize-1)[1] <= coords.get(0)[1];


        if (epsX && epsY){
            optimalDelVal = coordsSize;
            //  println("Optimal delVal: " + optimalDelVal); <-- reenable
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

    @Override
    public boolean scale(float... obj) {
        return false;
    }

    @Override
    public boolean display(Object... obj){
        addPoint();
        boolean b = graph();
        incrementor += speed;
        return b;
    }
}

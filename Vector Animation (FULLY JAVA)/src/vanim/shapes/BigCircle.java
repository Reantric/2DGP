package vanim.shapes;
import java.util.*;
import processing.core.*;

public class BigCircle extends MObject{
    List<float[]> coords;
    float size;
    int delVal;

    public BigCircle(PGraphics c, float size, int delValRGB){
        super(c,2,2,2,2,2); // will fix!
        this.size = size;
        delVal = delValRGB;
    }

    public void display(Object... obj){

    }



}
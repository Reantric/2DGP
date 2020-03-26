package vanim.shapes;

import vanim.misc.*;
import static vanim.misc.Mapper.*;
import static vanim.planar.*;
import processing.core.*;

public class TextMObject extends MObject {
    String str;
    float tSize;
    float transp = 0;
    public TextMObject(PGraphics c, String s, float x, float y, float size, float colHue){
        super(c,x,y,colHue);
        c.textSize(size);
        width = c.textWidth(s) * 0.9f;
        height = size;
        tSize = size;
        str = s;
    }

    public boolean display(Object... obj){
        this.backgroundRect();
        canvas.textSize(tSize);
        canvas.fill(hue,hue != 0 ? 255 : 0,255,map2(transp,0,255,0,255,QUADRATIC,EASE_IN));
        canvas.text(str,pos.x,pos.y);
        //map2(float value, float start1, float stop1, float start2, float stop2, int type, int when) {
        // println("NORMAL: " + map(transp,0,255,0,255) + " IMPROVED: " + map2(transp,0,255,0,255,QUADRATIC,EASE_IN));
        if (transp < 255)
            transp += 4;

        return transp > 255;

    }

}
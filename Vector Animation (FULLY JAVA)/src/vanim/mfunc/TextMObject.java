package vanim.mfunc;

import vanim.misc.*;
import vanim.shapes.*;
import processing.core.*;


public class TextMObject extends MObject {
    String str;
    float tSize;
    float transp = 0;
    public TextMObject(PGraphics c, String s, float x, float y, float size, float colHue){
        super(c,x,y,size*s.length()/2.2f,size,colHue);
        tSize = size;
        str = s;
    }

    public void display(Object... obj){
        this.backgroundRect();
        canvas.textSize(tSize);
        canvas.fill(hue,hue != 0 ? 255 : 0,255,Mapper.map2(transp,0,255,0,255,Mapper.QUADRATIC,Mapper.EASE_IN));
        canvas.text(str,pos.x,pos.y);
        //map2(float value, float start1, float stop1, float start2, float stop2, int type, int when) {
        // println("NORMAL: " + map(transp,0,255,0,255) + " IMPROVED: " + map2(transp,0,255,0,255,QUADRATIC,EASE_IN));
        if (transp < 255)
            transp += 4;

    }

}
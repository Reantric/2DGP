package vanim.shapes;
import static vanim.planar.*;
import static processing.core.PApplet.*;
import processing.core.*;

public abstract class VObject {
    public int frameCountInit;
    public int frameCountBuffer;
    public PVector pos;
    public float width;
    public float height;
    public PGraphics canvas;
    public float hue,sat,bri;
    public PApplet processing;
    public float incrementor = 0;
    public float mapPower = 1;

    public VObject(PGraphics c, float x, float y, float colHue){
        this(null,c,x,y,0,0,colHue,255,255);
    }//add mapper and points[] ?

    public VObject(PGraphics c, float x, float y, float w, float h, float colHue,float colSat, float colBright){
        this(null,c,x,y,w,h,colHue,colSat,colBright);
    }

    public VObject(PApplet p,PGraphics c, float x, float y, float w, float h, float colHue,float colSat, float colBright){
        //println("IS NULL? " + p);
        processing = p;
        canvas = c;
        pos = new PVector(x,y);
        width = w;
        height = h;
        hue = colHue;
        sat = colSat;
        bri = colBright;
    }

    public VObject(PApplet p, PGraphics c, float x, float y, float colHue){
        this(p,c,x,y,0,0,colHue,255,255);
    }

    public VObject(PGraphics c, float x, float y, float colHue, float colSat, float colBright){
        this(null,c,x,y,0,0,colHue,colSat, colBright);
    }

    public VObject(PApplet p,PGraphics c,float x, float y,float s, float colHue, float colSat, float colBright) {
        this(null,c,x,y,s,s,colHue,colSat,colBright);
    }

    public VObject(PApplet p, PGraphics c, float x, float y, float w, float h) {
        this(p,c,x,y,w,h,0,0,0);
    }

    public VObject(PGraphics c, float x, float y, float size, int colHue, int colSat, int colBright) {
        this(null,c,x,y,size,size,colHue,colSat,colBright);
    }

    public void setWidth(float nw){
        width = nw;
    }

    public void setHeight(float nh){
        height = nh;
    }

    public void setWidthHeight(float nw, float nh){
        width = nw;
        height = nh;
    }

    public void backgroundRect(){ // work on this tom it is now tom
        canvas.noStroke();
        canvas.fill(0,0,0,125); //125
        if (canvas.textAlign == LEFT){
            canvas.rectMode(CORNER);
            canvas.rect(pos.x,pos.y-height + 14,width,height);
        }
        else {
            canvas.rectMode(CENTER);
            canvas.rect(pos.x,pos.y - 14,width,height);
        }

    }

    //rotate, translate, move, a lot more!
    public abstract boolean scale(float... obj); // Scale up the VObject
    public abstract boolean display(Object... obj); // Display the VObject
}
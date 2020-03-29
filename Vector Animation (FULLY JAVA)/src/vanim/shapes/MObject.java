package vanim.shapes;
import static vanim.planar.*;
import static processing.core.PApplet.*;
import processing.core.*;

public abstract class MObject {
    public int frameCountInit;
    public int frameCountBuffer;
    public PVector pos;
    public float width;
    public float height;
    public PGraphics canvas;
    public float hue;
    public PApplet processing;
    public float incrementor = 0;
    public float mapPower = 1;

    public MObject(PGraphics c, float x, float y, float colHue){
        this(null,c,x,y,0,0,colHue);
    }//add mapper and points[] ?

    public MObject(PApplet p,PGraphics c, float x, float y, float w, float h, float colHue){
        //println("IS NULL? " + p);
        processing = p;
        canvas = c;
        pos = new PVector(x,y);
        width = w;
        height = h;
        hue = colHue;
    }

    public MObject(PApplet p, PGraphics c, float x, float y, float colHue){
        this(p,c,x,y,0,0,colHue);
    }

    public MObject(PGraphics c,float x, float y,float s, float colHue) {
        this(null,c,x,y,s,s,colHue);
    }

    public void backgroundRect(){ // work on this tom it is now tom
        canvas.noStroke();
        canvas.fill(0,0,0,125);
        if (canvas.textAlign == LEFT){
            canvas.rectMode(CORNER);
            canvas.rect(pos.x,pos.y-height+14,width,height);
        }
        else {
            canvas.rectMode(CENTER);
            canvas.rect(pos.x,pos.y+10,width,height);
        }

    }

    //rotate, translate, move, a lot more!

    public abstract boolean display(Object... obj);
}
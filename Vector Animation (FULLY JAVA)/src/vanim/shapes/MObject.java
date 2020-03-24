package vanim.shapes;

import processing.core.*;

public abstract class MObject {
    public PVector pos;
    public float width;
    public float height;
    public PGraphics canvas;
    public float hue;
    public PApplet processing;

    public MObject(PGraphics c, float x, float y, float colHue){
        this(null,c,x,y,0,0,colHue);
    }

    public MObject(PApplet p, PGraphics c, float x, float y, float w, float h, float colHue){
        processing = p;
        canvas = c;
        pos = new PVector(x,y);
        width = w;
        height = h;
        hue = colHue;
    }

    public MObject(PGraphics c,float x, float y,float w, float h, float colHue) {
        this(null,c,x,y,w,h,colHue);
        //this.c = col;
    }

    public void backgroundRect(){ // work on this tom it is now tom
        canvas.noStroke();
        canvas.fill(0,0,0,125);
        if (canvas.textAlign == processing.LEFT){
            canvas.rectMode(processing.CORNER);
            canvas.rect(pos.x,pos.y-height+10,width,height);
        }
        else {
            canvas.rectMode(processing.CENTER);
            canvas.rect(pos.x,pos.y+10,width,height);
        }

    }

    //rotate, translate, move, a lot more!

    public abstract void display(Object... obj);
}
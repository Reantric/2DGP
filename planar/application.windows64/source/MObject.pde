//import java.awt.Color;

public abstract class MObject {
  PVector pos;
  float width;
  float height;
  PGraphics canvas;
  float hue;
  
  public MObject(PGraphics c, float x, float y, float colHue){
    this(c,x,y,0,0,colHue);
  }
  
  public MObject(PGraphics c,float x, float y,float w, float h, float colHue) {
    pos = new PVector(x,y);
    width = w; 
    height = h;
    canvas = c;
    hue = colHue;
    //this.c = col;
  }
  
  public void backgroundRect(){ // work on this tom it is now tom
    canvas.noStroke();
    canvas.fill(0,0,0,125);
    if (canvas.textAlign == LEFT){
      canvas.rectMode(CORNER);
      canvas.rect(pos.x,pos.y-height+10,width,height);
    }
    else {
      canvas.rectMode(CENTER);
      canvas.rect(pos.x,pos.y+10,width,height);
    }
    
  }
  
  //rotate, translate, move, a lot more!
  
  public abstract void display(Object... obj);
}

public class TextMObject extends MObject {
  String str;
  float tSize;
  float transp = 0;
  public TextMObject(PGraphics c,String s, float x, float y, float size, float colHue){
    super(c,x,y,size*s.length()/2.2,size,colHue);
    tSize = size;
    str = s;
  }
  
  public void display(Object... obj){
    this.backgroundRect();
    canvas.textSize(tSize);
    canvas.fill(hue,hue != 0 ? 255 : 0,255,map2(transp,0,255,0,255,QUADRATIC,EASE_IN));
    canvas.text(str,pos.x,pos.y);
    //map2(float value, float start1, float stop1, float start2, float stop2, int type, int when) {
   // println("NORMAL: " + map(transp,0,255,0,255) + " IMPROVED: " + map2(transp,0,255,0,255,QUADRATIC,EASE_IN));
    if (transp < 255)
      transp += 4;
      
  }
  
}

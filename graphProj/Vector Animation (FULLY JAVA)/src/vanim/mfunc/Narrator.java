package vanim.mfunc;

import vanim.planar;
import vanim.shapes.*;
import processing.core.*;
import java.util.*;
import static vanim.planar.*;

public class Narrator {
    PGraphics canvas;
    List<MObject> allText = new ArrayList<MObject>();
    public Narrator(PGraphics c){
        canvas = c;
        setupNarrator();
    }


    public void setupNarrator(){
        allText.add(new TextMObject(canvas,"2D Graphing - Vector Animation",-930,-460,80,30));
        allText.add(new TextMObject(canvas,"Vanim",-660,-320,130,77));
    }


    public void narration() {
        canvas.textAlign(LEFT);
        canvas.textSize(70);
        //canvas.text("Sample text",-790,-420);
      //  for (MObject m: allText)
         //   m.display();
    }

    public void afterNarration() {

    }

    public void narrate() {
        narration();
        afterNarration();
    }

    public void test() {
        println("I exist!");
    }
}
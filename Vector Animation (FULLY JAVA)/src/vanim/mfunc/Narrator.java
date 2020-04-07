package vanim.mfunc;

import vanim.planar;
import vanim.shapes.*;
import processing.core.*;
import java.util.*;
import static vanim.planar.*;

public class Narrator {
    PGraphics canvas;
    List<TextVObject> allText = new ArrayList<>();
    public Narrator(PGraphics c){
        canvas = c;
        setupNarrator();
    }


    public void setupNarrator(){
        allText.add(new TextVObject(canvas,"But how do we find the slope of the tangent line?",-630,-480,80,30));
      //  allText.add(new TextVObject(canvas,"Vanim",-660,-320,130,77));
    }


    public boolean narration() {
        boolean b = true;
        canvas.textAlign(LEFT);
        canvas.textSize(70);
        for (TextVObject m: allText) {
            m.setDisplayRect(false);
            if (!m.display())
                b = false;
        }

        return b;
    }

    public boolean afterNarration() {
        return true;
    }

    public boolean narrate() {
        narration();
        afterNarration();
        return narration() & afterNarration();
    }

    public void test() {
        println("I exist!");
    }
}
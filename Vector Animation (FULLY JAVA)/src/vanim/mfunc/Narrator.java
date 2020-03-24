package vanim.mfunc;

import vanim.planar;
import vanim.shapes.*;
import processing.core.*;

public class Narrator {
    PGraphics canvas;
    MObject tN;
    public Narrator(PGraphics c){
        canvas = c;
        setupNarrator();
    }


    public void setupNarrator() {
        tN = new TextMObject(canvas, "Hello there", -790, -320, 70, 0);
    }


    public void narration() {
        canvas.textAlign(PApplet.LEFT);
        canvas.textSize(70);
        canvas.text("Sample text", -790, -420);
        tN.display();
    }

    public void afterNarration() {

    }

    public void narrate() {
        narration();
        afterNarration();
    }

    public void test() {
        planar.println("I exist!");
    }
}
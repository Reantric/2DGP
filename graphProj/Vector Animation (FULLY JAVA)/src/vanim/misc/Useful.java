package vanim.misc;
import processing.core.*;
import static vanim.planar.*;

public class Useful {
    
    public static double floorAny(double jjfanman, double val){ // can only sPApplet.PIt out integers... damn thsi!
        return  val*Math.floor(jjfanman/val);
    }

    public static double ceilAny(double jjfanman, double val){
        return val*Math.ceil(jjfanman/val);
    }

    public static String propFormat(float x){
        double eps = PApplet.round(x) / x;
        if (eps > 0.9f && eps < 1.1f)
            return Integer.toString(PApplet.round(x));

        // assuming square roots!
        return "√" + Integer.toString(PApplet.round(x*x));
    }

    /**
     *
     * Cycle through all colors of the rainbow
     */
    public static float getColor(float m,float lowerBound,float upperBound){
        return PApplet.map(m,lowerBound,upperBound,0,255);
    }

    public static void rotatedText(String txt, PGraphics c, float x, float y, float theta){
        c.pushMatrix();

        c.translate(x,y); // where to place TXT?

        c.pushMatrix();

        if (theta < 0)
            theta += PApplet.TAU;


        // println(theta);

        if (theta < 3*PApplet.PI/2 && theta > PApplet.PI/2){ //centBottom both does work, but it is a jarring experience!
            c.textAlign(PApplet.CENTER,PApplet.TOP);
            c.rotate(theta-PApplet.PI);
        }
        else {
            c.textAlign(PApplet.CENTER,PApplet.BOTTOM);
            c.rotate(theta);
        }




        c.text(txt,0,0);
        c. popMatrix();

        c.popMatrix();
    }

    /**
     * Get derivative given two values
     */
    public static float derivative(float y1, float y2, float distX){
        return (y2-y1)/distX;
    }

}
package vanim.misc;
import vanim.mfunc.*;
import processing.core.PGraphics;

public class Useful {
    
    public static double floorAny(double jjfanman, double val){ // can only splanar.PIt out integers... damn thsi!
        return  val*Math.floor(jjfanman/val);
    }

    public static double ceilAny(double jjfanman, double val){
        return val*Math.ceil(jjfanman/val);
    }

    public static String propFormat(float x){
        double eps = planar.round(x) / x;
        if (eps > 0.9f && eps < 1.1f)
            return Integer.toString(planar.round(x));

        // assuming square roots!
        return "√" + Integer.toString(planar.round(x*x));
    }

    /**
     *
     * Cycle through all colors of the rainbow
     */
    public static float getColor(float m,float lowerBound,float upperBound){
        return planar.map(m,lowerBound,upperBound,0,255);
    }

    public static void rotatedText(String txt, PGraphics c, float x, float y, float theta){
        c.pushMatrix();

        c.translate(x,y); // where to place TXT?

        c.pushMatrix();

        if (theta < 0)
            theta += planar.TAU;


        // println(theta);

        if (theta < 3*planar.PI/2 && theta > planar.PI/2){ //centBottom both does work, but it is a jarring experience!
            c.textAlign(planar.CENTER,planar.TOP);
            c.rotate(theta-planar.PI);
        }
        else {
            c.textAlign(planar.CENTER,planar.BOTTOM);
            c.rotate(theta);
        }




        c.text(txt,0,0);
        c. popMatrix();

        c.popMatrix();
    }

}
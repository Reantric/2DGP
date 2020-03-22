import java.lang.*;

public static class Useful {
  
  public static double floorAny(double jjfanman, double val){ // can only spit out integers... damn thsi!
    return  val*Math.floor(jjfanman/val);
}

  public static double ceilAny(double jjfanman, double val){
    return val*Math.ceil(jjfanman/val);
}
  
  public static String propFormat(float x){
    double eps =  round(x) / x;
    if (eps > 0.9 && eps < 1.1)
      return Integer.toString(round(x));
     
     // assuming square roots!
     return "√" + Integer.toString(round(x*x));
  }
  
  /**
  *
  * Cycle through all colors of the rainbow
  */
  public static float getColor(float m,float lowerBound,float upperBound){
    return map(m,lowerBound,upperBound,0,255);
  }
    
  public static void rotatedText(String txt,PGraphics c, float x, float y, float theta){
    c.pushMatrix();
     
        c.translate(x,y); // where to place TXT?
      
        c.pushMatrix();
        
        if (theta < 0)
          theta += TAU;
        

       // println(theta);
         
          if (theta < 3*PI/2 && theta > PI/2){ //centBottom both does work, but it is a jarring experience!
             c.textAlign(CENTER,TOP);
             c.rotate(theta-PI);
          }
          else {
             c.textAlign(CENTER,BOTTOM);
             c.rotate(theta);
          }


          
          
        c.text(txt,0,0);
   c. popMatrix();
   
    c.popMatrix();
  }
  
}

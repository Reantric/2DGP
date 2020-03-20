import java.lang.*;

public static class Useful {
  
  public static int floorAny(double jjfanman, double val){
    return (int) (val*Math.floor(jjfanman/val));
}

  public static int ceilAny(double jjfanman, double val){
    return (int) (val*Math.ceil(jjfanman/val));
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
      
        c.rotate(theta);
        
       // println(CENTER);
        c.textAlign(CENTER,BOTTOM);
        
        c.text(txt,0,0);
   c. popMatrix();
   
    c.popMatrix();
  }
  
}

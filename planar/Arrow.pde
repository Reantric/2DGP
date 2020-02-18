public class Arrow extends Easing {
  PVector vector = new PVector(0,0);
  boolean follow;
  float triangleSize;
  
  public Arrow(float tS, boolean graphDependent){ //  public Easing(float c, float i, float e) Fix triangle not easing correctly!
    super(0,tS);
    triangleSize = tS;
    follow = graphDependent;
  }
  
  
  public void doStuff(float easeInc){
     // vectorMag = vector.mag();
      
      if (vector.x > -5 && vector.x < 0){
        this.incEase(easeInc);
        super.doStuff();
      }
      
      if (vector.x > 0){
        this.setChange(triangleSize);
     
        if (follow){
          this.reset();
          easing = 0.006;
          follow = false;
        }
        
        this.incEase(easeInc);
        super.doStuff();
      }
      
     // System.out.println(this.vector);
    //  System.out.println(vectorMag);
      
  }
  
}

public class Arrow extends Easing {
  PVector vector = new PVector(0,0);
  boolean follow;
  public Arrow(float triangleSize, boolean graphDependent){
    super(triangleSize);
    follow = graphDependent;
  }
  
  public void closeToOrigin(boolean closeToZero){ // if follow == true
     if (closeToZero){
        this.incEase(1.045);
        this.doStuff();
      }
      
      else
        this.setChange(12);
  }
  
//  @Override
  public void doStuff(boolean closeToZero){
      closeToOrigin(closeToZero);
      if (this.easing < 0.05 && !this.isEqual())
          this.multEase();
        
        
        if (!this.isEqual())
          this.incValue();
       

        if (this.isEqual())
          this.reset();
    }
  
}

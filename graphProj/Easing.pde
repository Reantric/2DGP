public class Easing {
    float easing;
    float incrementor;
    float change; //finalRotation in CP case
    float easeMultiplier = 1;
    
    public Easing(float c, float i, float e) { // Add incrementor constructor as well (for non 0 start!)
        change = c;
        incrementor = i;
        easing = e;
    }
    
    public Easing(float c, float i){
       change = c;
       incrementor = i;
       easing = 0.0004;
    }
    
    public Easing(float c){
      change = c;
      incrementor = 0;
      easing = 0.0004;
    }
    
    public void doStuff(){
      if (this.easing < 0.05 && !this.isEqual())
          this.multEase();
        
        
        if (!this.isEqual())
          this.incValue();
       

        if (this.isEqual())
          this.reset();
    }
    
    public boolean isEqual() {
        return abs(incrementor/change) > 0.999 && abs(incrementor/change) < 1.001;
    }

    /**
     *
     * @param stop
     * @return Linear interpolated value
     */
    public void incValue(){ // Make quadratic/polynomial later!
        incrementor = lerp(incrementor,change,easing);
    }

    /**
     *
     * @param ch
     * Set change to param
     */
    public void setChange(float ch) {
        change = ch;
    }

    /**
     * Reset easing to default value of 0.0004
     */
    public void reset() {
        easing = 0.0004;
    }

    /**
     *
     * @param i Increase ease by multiplier "i"
     */
    public void incEase(float i){
       easeMultiplier = i;
        
    }
    
    public void multEase(){
       easing *= easeMultiplier;
    }
    
    @Override
    public String toString(){
      return "CHNG: " + change + " INC: " + incrementor + " EASING: " + easing;
    }
}

public class Easing {
    float easing;
    float incrementor;
    float change; //finalRotation in CP case
    
    public Easing(float c, float e) {
        change = c;
        easing = e;
    }
    
    public Easing(float c){
      change = c;
      easing = 0.0004;
    }
    
    public boolean isEqual() {
        return abs(incrementor-change) < 0.01;
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
        easing *= i;
    }
}

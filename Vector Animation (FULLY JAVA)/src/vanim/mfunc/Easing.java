package vanim.mfunc;
import vanim.planar;
import static vanim.planar.*;

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
        easing = 0.0004f;
    }

    public Easing(float c){
        change = c;
        incrementor = 0;
        easing = 0.0004f;
    }

    public void doStuff(){
        if (this.easing < 0.05f && !this.isEqual())
            this.multEase();


        if (!this.isEqual())
            this.incValue();


        if (this.isEqual())
            this.reset();
    }

    public boolean isEqual() {
        return abs(incrementor-change) < 0.01f;
    }

    /**
     *
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
        easing = 0.0004f;
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
}
public class Easing {
    float easing = 0.0004;
    float incrementor = 0;
    float change;
    public Easing(float c) {
        change = c;
    }

    public boolean s() {
        // To be implemented
        return true;
    }

    /**
     *
     * @param start
     * @param stop
     * @return Linear interpolated value
     */
    public float incValue(float start, float stop){ // Make quadratic/polynomial later!
        return lerp(start,stop,easing);
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
    public void resetEase() {
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

package vanim.misc;
import processing.core.*;

public class Mapper {
    /* The map2() function supports the following easing types */
    public static final int LINEAR = 0;
    public static final int QUADRATIC = 1;
    public static final int CUBIC = 2;
    public static final int QUARTIC = 3;
    public static final int QUINTIC = 4;
    public static final int SINUSOIDAL = 5;
    public static final int EXPONENTIAL = 6;
    public static final int CIRCULAR = 7;
    public static final int SQRT = 8;

    /* When the easing is applied (in, out, or both) */
    public static final int EASE_IN = 0;
    public static final int EASE_OUT = 1;
    public static final int EASE_IN_OUT = 2;

    /*
     * A map() replacement that allows for specifying easing curves
     * with arbitrary exponents.
     *
     * value :   The value to map
     * start1:   The lower limit of the input range
     * stop1 :   The upper limit of the input range
     * start2:   The lower limit of the output range
     * stop2 :   The upper limit of the output range
     * type  :   The type of easing (see above)
     * when  :   One of EASE_IN, EASE_OUT, or EASE_IN_OUT
     */
    public static float map2(float value, float start1, float stop1, float start2, float stop2, int type, int when) {
        float b = start2;
        float c = stop2 - start2;
        float t = value - start1;
        float d = stop1 - start1;
        float p = 0.5f;
        switch (type) {
            case LINEAR:
                return c * t / d + b;
            case SQRT:
                if (when == EASE_IN) {
                    t /= d;
                    return c * PApplet.pow(t, p) + b;
                } else if (when == EASE_OUT) {
                    t /= d;
                    return c * (1 - PApplet.pow(1 - t, p)) + b;
                } else if (when == EASE_IN_OUT) {
                    t /= d / 2;
                    if (t < 1) return c / 2 * PApplet.pow(t, p) + b;
                    return c / 2 * (2 - PApplet.pow(2 - t, p)) + b;
                }
                break;
            case QUADRATIC:
                if (when == EASE_IN) {
                    t /= d;
                    return c * t * t + b;
                } else if (when == EASE_OUT) {
                    t /= d;
                    return -c * t * (t - 2) + b;
                } else if (when == EASE_IN_OUT) {
                    t /= d / 2;
                    if (t < 1) return c / 2 * t * t + b;
                    t--;
                    return -c / 2 * (t * (t - 2) - 1) + b;
                }
                break;
            case CUBIC:
                if (when == EASE_IN) {
                    t /= d;
                    return c * t * t * t + b;
                } else if (when == EASE_OUT) {
                    t /= d;
                    t--;
                    return c * (t * t * t + 1) + b;
                } else if (when == EASE_IN_OUT) {
                    t /= d / 2;
                    if (t < 1) return c / 2 * t * t * t + b;
                    t -= 2;
                    return c / 2 * (t * t * t + 2) + b;
                }
                break;
            case QUARTIC:
                if (when == EASE_IN) {
                    t /= d;
                    return c * t * t * t * t + b;
                } else if (when == EASE_OUT) {
                    t /= d;
                    t--;
                    return -c * (t * t * t * t - 1) + b;
                } else if (when == EASE_IN_OUT) {
                    t /= d / 2;
                    if (t < 1) return c / 2 * t * t * t * t + b;
                    t -= 2;
                    return -c / 2 * (t * t * t * t - 2) + b;
                }
                break;
            case QUINTIC:
                if (when == EASE_IN) {
                    t /= d;
                    return c * t * t * t * t * t + b;
                } else if (when == EASE_OUT) {
                    t /= d;
                    t--;
                    return c * (t * t * t * t * t + 1) + b;
                } else if (when == EASE_IN_OUT) {
                    t /= d / 2;
                    if (t < 1) return c / 2 * t * t * t * t * t + b;
                    t -= 2;
                    return c / 2 * (t * t * t * t * t + 2) + b;
                }
                break;
            case SINUSOIDAL:
                if (when == EASE_IN) {
                    return -c * PApplet.cos(t / d * (PApplet.PI / 2)) + c + b;
                } else if (when == EASE_OUT) {
                    return c * PApplet.sin(t / d * (PApplet.PI / 2)) + b;
                } else if (when == EASE_IN_OUT) {
                    return -c / 2 * (PApplet.cos(PApplet.PI * t / d) - 1) + b;
                }
                break;
            case EXPONENTIAL:
                if (when == EASE_IN) {
                    return c * PApplet.pow(2, 10 * (t / d - 1)) + b;
                } else if (when == EASE_OUT) {
                    return c * (-PApplet.pow(2, -10 * t / d) + 1) + b;
                } else if (when == EASE_IN_OUT) {
                    t /= d / 2;
                    if (t < 1) return c / 2 * PApplet.pow(2, 10 * (t - 1)) + b;
                    t--;
                    return c / 2 * (-PApplet.pow(2, -10 * t) + 2) + b;
                }
                break;
            case CIRCULAR:
                if (when == EASE_IN) {
                    t /= d;
                    return -c * (PApplet.sqrt(1 - t * t) - 1) + b;
                } else if (when == EASE_OUT) {
                    t /= d;
                    t--;
                    return c * PApplet.sqrt(1 - t * t) + b;
                } else if (when == EASE_IN_OUT) {
                    t /= d / 2;
                    if (t < 1) return -c / 2 * (PApplet.sqrt(1 - t * t) - 1) + b;
                    t -= 2;
                    return c / 2 * (PApplet.sqrt(1 - t * t) + 1) + b;
                }
                break;
        }
        ;
        return 0;
    }

    /*
     * A map() replacement that allows for specifying easing curves
     * with arbitrary exponents.
     *
     * value :   The value to map
     * start1:   The lower limit of the input range
     * stop1 :   The upper limit of the input range
     * start2:   The lower limit of the output range
     * stop2 :   The upper limit of the output range
     * v     :   The exponent value (e.g., 0.5, 0.1, 0.3)
     * when  :   One of EASE_IN, EASE_OUT, or EASE_IN_OUT
     */
    public float map3(float value, float start1, float stop1, float start2, float stop2, float v, int when) {
        float b = start2;
        float c = stop2 - start2;
        float t = value - start1;
        float d = stop1 - start1;
        float p = v;
        float out = 0;
        if (when == EASE_IN) {
            t /= d;
            out = c * PApplet.pow(t, p) + b;
        } else if (when == EASE_OUT) {
            t /= d;
            out = c * (1 - PApplet.pow(1 - t, p)) + b;
        } else if (when == EASE_IN_OUT) {
            t /= d / 2;
            if (t < 1) return c / 2 * PApplet.pow(t, p) + b;
            out = c / 2 * (2 - PApplet.pow(2 - t, p)) + b;
        }
        return out;
    }
}
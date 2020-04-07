package vanim.mfunc;

import processing.core.*;

interface Plane {
    boolean generatePlane();
    boolean scale(float... obj); //1-2 args for scale
    void rotatePlane(float theta);
    void moveVector(PVector initial, PVector output);
    boolean display(Object... obj);
}

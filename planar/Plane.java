import processing.core.*;

interface Plane {
    void generatePlane();
    void autoscale();
    void rotatePlane(float theta);
    void moveVector(PVector initial, PVector output);
    void display(Object... obj);
}

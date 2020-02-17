import processing.core.PVector;

interface Plane {
    void generatePlane();
    void autoscale();
    void rotatePlane(float theta);
    void moveVector(PVector initial, PVector output);
    void run(PGraphics p);
}

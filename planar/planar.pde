float e = 1;
CartesianPlane plane;
Scaling c = new Scaling(0);
int max = -width/2;
float angle;
PFont myFont;
PGraphics canvas;
float inc = 0;
Arrow arr;

void setup() {
  size(1920, 1080, P2D);
  myFont = createFont("cmunbmr.ttf", 150, true);
  textFont(myFont, 64);
  canvas = createGraphics(1920, 1080, P2D);
  plane = new CartesianPlane(3, 3, canvas);
  arr = new Arrow(6*cos(inc), 6*sin(inc));
  smooth(8);
  shapeMode(CENTER);
}


public class slowLine {
  int count = 0;
  public boolean slowLine(float x1, float y1, float x2, float y2) {
    //-0.2*x*(x-5) is the equation... for x = time since called
    if (count > 99) {
      line(x1, y1, x2, y2);
      return false;
    }
    count++;
    float diffX = (x2 - x1)/100;
    float diffY = (y2 - y1)/100;
    stroke(255);
    strokeWeight(5);
    line(x1, y1, x1+diffX*count, y1+diffY*count);
    return true;
  }
}

void directions() {
  plane.rotatePlane(angle);
  arr.setVector(6*cos(inc),6*sin(inc));
  plane.drawVector(arr);
  //  plane.createPoint(20,-20);
  inc += 0.01;
  //  plane.createPoint(40,20);
}

void narration(){
  canvas.text("Here's text!",-200,-400);
}

void mouseWheel(MouseEvent event) {
  e += -0.07*event.getCount();
}

void increaseScale() {
  e += 0.01;
}

void keyPressed() {
  switch (key) {
  case 'v':
    angle = PI/2;
    break;
  case 'c':
    angle = 0;
    break;
  case 'd':
    plane.restrictDomain(-PI/2, PI/2);
    break;
  case 's':
    plane.sY *= 1.1;
    break;
  case 'x':
    frameRate(2);
    break;
  }
}

void draw() {
  background(0);
  scale(e);
  plane.run(canvas);
  plane.generatePlane();
  // plane.graph();
  directions();
  narration();
  plane.display(0, 0);

  //saveFrame("rotate90/line-######.png");
  // directions();
}

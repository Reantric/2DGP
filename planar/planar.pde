float e = 1;
slowLine a;
CartesianPlane plane;
Scaling c = new Scaling(0);
int max = -width/2;
PFont myFont;

void setup(){
  size(1920,1080,P2D);
  a = new slowLine();
  //println(Arrays.toString(PFont.list()));
 // myFont = loadFont("test.vlw");
  myFont = createFont("Lato Bold",150,true);
  textFont(myFont, 32);
  plane = new CartesianPlane(5,5);
  smooth(8);
}


public class slowLine {
   int count = 0;
   public boolean slowLine(float x1, float y1, float x2, float y2){
     //-0.2*x*(x-5) is the equation... for x = time since called
      if (count > 99){
        line(x1,y1,x2,y2);
        return false;
      }
      count++;
      float diffX = (x2 - x1)/100;
      float diffY = (y2 - y1)/100;
      stroke(255);
      strokeWeight(5);
      line(x1,y1,x1+diffX*count,y1+diffY*count);
      return true;
      
    }
}

void directions(){
  if (a.slowLine(200,200,200,-200))
    return;
  
  plane.createPoint(20,-20);
  plane.createPoint(40,20);
}

void mouseWheel(MouseEvent event) {
  e += -0.07*event.getCount();
}

void increaseScale(){
  e += 0.01;
}

void keyPressed(){
  switch (key){
    case 'v':
      plane.rotatePlane(PI/2);
      break;
    case 'c':
      plane.rotatePlane(0);
      break;
    case 'd':
      plane.restrictDomain(-PI/2,PI/2);
      break;
    case 's':
      plane.sY *= 1.1;
      break;
  }
}

void draw(){
 // translate(width/2,height/2);scale(e);
  scale(e);
  plane.generatePlane();
  plane.graph();
 // saveFrame("rotate90/line-######.png");
 // directions();
}

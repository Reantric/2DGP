float max = 0;
float angle = 0;


void setup(){
  size(1000,800);
  smooth(8);
  textSize(25);
}

float f(double x){
  return (float) Math.sqrt(80000-Math.pow(x,2));
}
void graph(){
  stroke(255);
  strokeWeight(4);
  for (float x = -max; x < max; x+= 0.2){
    line(x-0.2,f(x+0.2),x,f(x));
    line(x-0.2,-f(x+0.2),x,-f(x));
  }
}

void centerDot(){
  noStroke();
  fill(255,0,0);
  circle(0,0,9);
}

void lineFade(){
}
//
public class Tringle{
  int r,g,b;
  public Tringle(int r, int g, int b){
    this.r = r;
    this.g = g;
    this.b = b;
  }
  float angle = 0;
  public void triangleIt(float speed){
  angle += 0.001*speed;
  //float a = (float) max/90;
  stroke(r,g,b);
  //line((float) -Math.sqrt(80000),0,(float) Math.sqrt(80000),0);
  line(0,0,(float) (Math.sqrt(80000)*cos(angle)),0);
  text((float) (Math.sqrt(80000)*cos(angle)),((float) (Math.sqrt(80000)*cos(angle)))/3,30);
  text((float) (Math.sqrt(80000)*sin(angle)),(float) (Math.sqrt(80000)*cos(angle)),((float) -(Math.sqrt(80000)*sin(angle)))/2);
  line(0,0,(float) (Math.sqrt(80000)*cos(angle)), (float) -(Math.sqrt(80000)*sin(angle)));
  line((float) (Math.sqrt(80000)*cos(angle)),0,(float) (Math.sqrt(80000)*cos(angle)),(float) -(Math.sqrt(80000)*sin(angle)));
  fill(255);
  noStroke();
  arc(0, 0, 60, 60, (float) (-(angle%(2*Math.PI))+radians(0.2)), radians(0.2));
}
}
Tringle t1 = new Tringle(255,0,0);
void draw(){
  background(0);
  translate(width/2,height/2);
  t1.triangleIt(3);
  centerDot();
  graph();
  if (max < 200*Math.sqrt(2)){
      max+=1;
  } else {
    line(282.64,-3,282.64,3);
    line(-282.8,-3,-282.8,1);
  }
}

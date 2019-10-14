import java.lang.Math;
import java.text.DecimalFormat;
DecimalFormat df = new DecimalFormat("#.0");
int maximum = -100;
double scaleX = 1; //10 = 10x zoom OUT
double scaleY = 1;
int count = 0;
float timescale = 0.12; // 0.2 ---> 5x slower
double xVal;

void setup(){
    size(1000,1000);
    PFont myFont = createFont("Lato", 16);
    textFont(myFont,36);
 }


double f(double x){
    return Math.pow(x,2);
}

double dx(double x){ //return the exact derivative of the function at x
  float dx = 0.00001f;
  return -1*(f(x+dx) - f(x))/dx;
}

void draw(){
    frameRate(timescale*120);
    if (maximum < 801){
        maximum += 1;
    }
    count += 1;
    //println(count);
    background(0);
    translate(width/2,height/2);
    stroke(255);
    line(0,-height/2,0,height/2);
    line(-width/2,0,width/2,0);
    stroke(255,0,0);
    
    for (int i = 50; i < 600; i+= 40){ //y values
      //strokeWeight(2);
      line(-7,-1*i,7,-1*i);
      textSize(20);
      text(i,10,-1*i);
    }
    //basic initialization
    //textSize(30);
    
    for (int x = (maximum - 300); x < maximum; x++){ //all this does is advance the function one xVal -->! (which is determined by timeScale)
        xVal = x;
        strokeWeight(2);
        stroke(200,120,3);
        line((float) (scaleX * xVal), (float) (-1*f(xVal)), (float) (scaleX * (xVal-1)), (float) (-1 * f(xVal-1)) );
        fill(0);
        stroke(0);
        rect(350, -480, 222, 50);
        stroke(255);
        fill(255);
        
      
        text(df.format(scaleX*xVal)+","+ df.format(f(scaleX*xVal)), 360,-460);
    }
    double push = Math.sqrt(2500/(1+Math.pow(dx(scaleX*xVal),2))); //slope of the tangent line amount to push off the X!
    line((float) (scaleX*xVal-push), (float) (-1 * f(xVal)-(dx(scaleX*xVal)*push)), (float) (scaleX*xVal+push), (float) (-1 * f(xVal)+(dx(scaleX*xVal)*push)));
    stroke(255,10,10);
    fill(255,40,40);
    circle((float)(scaleX * xVal),(float) (-1*f(xVal)),8);
    strokeWeight(1);
}

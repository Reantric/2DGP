import processing.sound.*;
import java.util.*;
import java.util.stream.Collectors;

SoundFile file;

boolean scalingDone = true;
boolean rescale = false;
boolean linesGone = false;
boolean runOnce = false;
boolean moving = false;

//PShader blur;

double midline;
double doublingFactor;
double xCoord[];
double yCoords[][];
double dx;

int max = 0;
int newWidth = 1200; // i guess i gotta hard code this in :(
int tailLength = 2000;
int margin = 320;
int starting = 0;

float scale = 1;
float e = 1;
float xPush = 500;
double relMax = 2;
double value = 100; //DO NOT TOUCH!
Map<Double,double[]> coords = new HashMap<Double,double[]>();
float sX = 1;
float sY = 2; //default : 2
float scaleMultiplier = 2;
float transpYScale = 255, transp2 = 0;
float boundary = 1;
float fS = 1;
double scalar = scaleMultiplier * value;


public class Scaling {
  boolean linesGone;
  float transparency;
  
  public Scaling(float transp){ //constructor overload later!
    this.linesGone = false;
    this.transparency = transp;
  }
  
  public float fadeOut(float multiplier){
 // println(Ttransp1 + " <<< transp1val ");
    if (transparency > 1.8){
      for (float t = 16; t > 0; t--){
        //println(transparency + " JohnJoe" + this);
        transparency -= multiplier*t/200;
      }
      return transparency;
    } else {
      linesGone = true;
      return 0;
    }
  }
  
  public void reset(){
    transparency = 255;
    linesGone = false;
  }
  
  public boolean isFinished(){
    return linesGone;
  }

}


Scaling yAxis = new Scaling(255);
Scaling xAxis = new Scaling(255);
  
void fetch(){
  
  String[] lines = loadStrings("datas.txt");
  String[] text = lines[0].split(" ");
  xCoord = new double[lines.length-1];
  yCoords = new double[lines.length - 1][text.length]; //yCoords[n][0]
  //println("there are " + lines.length + " lines");
  for (int i = 1 ; i < lines.length; i++) {
    double[] yVals = new double[text.length];
    String[] strHold = lines[i].split(" ");
    xCoord[i-1] = Double.parseDouble(strHold[0]);
    for (int x = 0; x < strHold.length-1; x++){
      yVals[x] = Double.parseDouble(strHold[x+1]);
    }
   // yCoord.add(yVals);
    yCoords[i-1] = yVals;
    coords.put(Double.parseDouble(strHold[0]),yVals);
    //yCoord.add(Arrays.asList().stream().map(n -> n * 3));
  }
  //println(yCoords[6][0]);
  //println("text: " + Arrays.toString(text), "xCoords: " + xCoord, "yCoords: " + yCoord.toString());
  //print("hashMap coords: " + coords);
  //for (Map.Entry<Double,double[]> entry : coords.entrySet()) {
       // System.out.println(entry.getKey() + ":" + Arrays.toString(entry.getValue()));
   // }
   
   //0 - 150 >--- maximus of that goes to maxArr
   
}

//final float minY = min(IT );

void setup(){
  fetch();
  size(1920,1080,P2D);
  PFont myFont = createFont("Lato",36,true);
  textFont(myFont,36);
  smooth(8);
}


float f(double x){
  //stroke(255,15,15);
  return (float) -Math.pow(x,1.4);
}

void info(){ //must multiply by reciprocal!
  //follow();
  fill(0);
  stroke(255);
  rect((float) (width/2 + xCoord[max] -xPush - 25),(float) -(height/2 + midline) + 4,350,height-4);
  fill(255);
  stroke(0);
  text(sX*xCoord[max]+","+ (yCoords[max][0]), (float) (width/2 + 70 + xCoord[max] - xPush),(float) -(midline + 410)); //index yCoords because it is a list of values, adding 1 should make such an insignifcant difference that it is not needed
  //(float) (double) xCoord.get(i), (float) (double) xCoord.get(i+1), (float) yCoord.get(i)[0],(float) yCoord.get(i+1)[0]
  text(sY,700,-80);
}

void follow(){
 // print(newWidth);
  //translate(newWidth/2 - sX*max,height/2 - sY*f(max));
  //translate((float) (newWidth/2 - 1/sX*(xCoord[max])),(float) (height/2 + 1/sY*yCoords[max][0]))
  // FOLLOW X AND Y : 
  if (1/sY*midline > 200){
  moving = true;
  translate((float) (newWidth/2 - (xCoord[max]) + xPush),(float) (height/2 + midline));
  } else {
    translate((float) (newWidth/2 - (xCoord[max]) + xPush),height - 50);
  }
   /* if (xCoord[max] > 1010){
   translate((float) (newWidth/2 - (xCoord[max]) + xPush),height-50);
   moving = true;
   } else {
     translate(90,height - 50);
  } */
  
 // stroke(255);
  //circle((float) (newWidth/2 - midline),-70,300);
}

/* void fadeOut(float multiplier){
 // println(transp1 + " <<< transp1val ");
    if (transp1 > 1.8){
      for (float t = 25; t > 0; t--){
       // println(transp1);
        transp1 -= multiplier*t/200;
      }
    } else {
     // println("Ending sY: " + sY);
      linesGone = true;
      //transp1 = 255;// <---troublesome!
    }
} */

float fadeOutT(float multiplier,float transparency){
 // println(Ttransp1 + " <<< transp1val ");
    if (transparency > 1.8){
      for (float t = 16; t > 0; t--){
       // println(transp1);
        transparency -= multiplier*t/200;
      }
      return transparency;
    } else {
      linesGone = true;
      return 0;
      //transp1 = 255;// <---troublesome!
    }
}

void fadeIn(){
 // println(transp1 + " <<< transp1val ");
    if (transp2 < 258){
      for (float t = 0; t > 25; t++){
       // println(transp1);
        transp2 += t/200;
      }
    }
}

int floor200(double jjfanman){
  return (int) (200*Math.floor(jjfanman/200));
}

void initGraph(){
  background(0);
  stroke(255);
  float xV = moving ? (float) xCoord[max] + 1000 : (float) xCoord[max] + 1400;
  strokeWeight(3);
 // line(0,(float) (sY*(-midline)-700),0,(float) -(sY*(-midline)-700));
  line(0,(float) -(sY*midline + 1000),0,0);
  //line(xV-xPush*2.5,0,xV+1000,0);
  line(0,0,xV,0);
  strokeWeight(1);
  
  //if value
  //println(starting);
  for (float a = starting; a < xV; a+=200){ //initialize lines and grid lines (x)
      if (a <= 0) {
        starting = floor200(xCoord[max] - width/2 - 15);
        textSize(25);
        //text(a,8,a-6);
        continue;
      }
      
     
      if (a < xCoord[max] - width/2 - 15){
        //begin fading!
        stroke(122,122,122, xAxis.fadeOut(5));
        fill(255, xAxis.fadeOut(5));
      } else {
        stroke(122,122,122);
        fill(255);
      }
      
      if (xAxis.isFinished()) {
        starting = floor200(xCoord[max] - width/2 - 15) + 200;
        xAxis.reset();
      }
     
      //fadeOut();
      line(a,-10000,a,0); //x-axis
      textSize(25);
      
      
      if (midline > (height/2)){
        text(Math.round(a/sX),a,height/2 - (float) (midline + 6));
      } else {
      text(Math.round(a/sX),a-16,30); // x-axis
    }
    
  }
  
   
  for (float b = 0; b < (float) 2/sY*(yCoords[max][0] + 900); b += value){ //y
    if (b == 0) continue;
    
   // println(b);
   if (sY > 4*boundary){ //add new ticks!
     println("dsjidsijsdijsdjisd");
     value /= 2;
     boundary *= 4;
     sY = boundary;
   }
   
    if (sY < boundary){ // shrinkinGraph code!
      if (yAxis.isFinished()){

      value = 200/boundary;
      scalar *= 2;
      boundary /= 2;
      linesGone = false;
      yAxis.reset();
      //transpYScale = 255;
      //println("SY : " + sY + " val: " + value + " bound: " + boundary); //Fade takes time to complete, and by the time it does complete, the scale is a little less than what it should be because Fade starts when its less than boundary.
      } else {
        //debug
       // println("B: " + boundary + " sY: " + sY);
      }
      
      
      if (b % scalar != 0){
       // println("Carykh");
       // fadeOut(1);
        //println(transpYScale);
        //transpYScale = fadeOutT(1,transpYScale);
        //yAxis.fadeOut();
        fill(255,255,255,yAxis.fadeOut(1));
        stroke(122,122,122,yAxis.fadeOut(1));
      } else {
        fill(255,255,255);
        stroke(122,122,122);
      }
    }
      //rescale = false;

    //println("transp1 VAL: " + transp1);
    
    essentialsY(b);
    
  }
    
    
      
    strokeWeight(4);
    stroke(255,120,120);
}

void slowIncreaseSY(float v){
  println("sY: " + sY + " v: " + v);
  if (sY < v){
    if (sY + v/1000 > v && sY < v){
      sY = v;
    } else {
  sY += v/1000;
    }
  }
}

void gracefulU(double val){
  //println("SY : " + sY + " val: " + value + " bound: " + boundary);
    for (float x = 0; x < 5; x++){
      if (sY / (1 + x/4500) < val){
        sY = (float) val;
        break;
      }
      
      sY /= (1 + x/4500);
    }
  

}


void linDec(double val,double dx){ //make quadratic :?
  if (sY > val){
    if (sY - dx*val/600 < val){
      sY = (float) val;
    } else 
    sY -= dx*val/600;
    
  } else {
    scalingDone = true;
    println("hiFinished!");
  }
  
}

void gracefulD(){
  //println("SY : " + sY + " val: " + value + " bound: " + boundary);
  if (sY < 5 && rescale){
    for (float x = 0; x < 10; x++){
      sY *= 1 + x/8000;
    }
  }
  
}

void instaChange(double val){
  if (relMax / 1.15 < boundary){
    relMax = boundary*0.99;
    gracefulU(relMax);
  }
  else {
    if (!scalingDone){
      sY = (float) val;
    } else {
      scalingDone = true;
    }
  }
}

void essentialsY(float n){
  //line(0,(-n)*sY,10000,(-n)*sY);
  if (xCoord[max] > newWidth/2 + xPush - 60){
      text(Math.round(n),(float) (xCoord[max] - newWidth/2 - xPush),(-n+5)*sY);
      line((float) xCoord[max]-width+900,(-n)*sY,10000,(-n)*sY); // < ---- adjusts the 1280 - value!
    } else {
    text(Math.round(n),-60,(-n + 5)*sY); // y-axis
    line(-10,(-n)*sY,10000,(-n)*sY);
    }
}

void graph(){
  initGraph();
  for (double x = max-200; x < max; x+= 0.05){ //actual Graph!
     double xU = x * sX;

     line((float) xU,sY*f(x),(float) (xU+0.002),sY*f(x+0.002)); 
     //circle((float) x,30,10); CANT HAVE THIS BECAUSE ITS BEING DRAWN 300 TIMES! 
    }
    noStroke();
    circle((float) (max*sX), sY*f(max), 10);
  
}

void sleep(int n){
  try
  {
    Thread.sleep(n);
  }
  catch(InterruptedException ex)
  {
    Thread.currentThread().interrupt();
  }
}

//turn 0.2649584985 ----> 0.25 well, 
boolean isPowerOfTwo(int x)
{
    return (x & (x - 1)) == 0;
   // isPowerOfTwo(1.0f/x)
}


void graphData(){
  initGraph();
  for (int i = max-tailLength; i < max; i++){ //change 0 to max-constant (keeps program a little efficient!)
    if (i < 0) continue;
    //print(i);s
    //sleep(1000);
    //println(yCoord.get(i)[0]);
    //println(max + " " + xCoord.get(i));
    stroke(255,20,20);
    line((float) xCoord[i], -sY* (float) yCoords[i][0], (float) xCoord[i+1], -sY* (float) yCoords[i+1][0]); //MESS WITH THIS !
    stroke(20,255,50);
    line((float) xCoord[i], -sY* (float) yCoords[i][1], (float) xCoord[i+1], -sY* (float) yCoords[i+1][1]);
    //filter(BLUR,0);
    }
    midline = sY * ((yCoords[max][0] + yCoords[max][1])/2);
    /*double[] average = new double[2];
    for (int g = 0; g < average.length; g++){
      average[g] = yCoords[max][g] - midline;
    }
    getTickY(average);
    */
        //fade();
    line((float) (xCoord[max] - 500),(float) -midline,(float) (xCoord[max] + 500),(float) -midline);
    //line(xCoord.get(x),yCoord.get(x));
    info();
    noStroke();
    circle((float) xCoord[max],(float) (-sY*yCoords[max][0]),12);
    circle((float) xCoord[max],(float) (-sY*yCoords[max][1]),12);
  // getScaleY(yCoords[max]);
    stroke(255);
    strokeWeight(10);
   // line(-700,-(float) (midline + 320),700,-(float) (midline + 320));
   // text("Line of God", -600, -(float) (midline + 340));
   // line((float) xCoord[max] - width/2 - 15,-500,(float) xCoord[max] - width/2 - 15,500);
    
    if (!scalingDone){
      dx = (sY*yCoords[max][0] - sY*yCoords[max-1][0])/(xCoord[max] - xCoord[max-1]);
      //println(dx);
    } 
    
    float maxVal = (float) getMaxValue(yCoords[max]); //localVar
    
    if ((midline + margin)/maxVal < relMax){
      relMax = (midline + margin)/maxVal;
   } //else println("relMax: " + relMax + " b: " + boundary + " dx " + dx);
    //relMax = (midline + margin)/yCoords[max][0];
   
  //put all this into a function!
    instaChange(relMax);
     
     
    if (sY*maxVal > midline + margin){
      scalingDone = false;
      //text((float) (1/sY * midline), -600, -(float) (midline + 340));
    }
    

   
    
    //circle(sX*200,sY*  300,40); i^ and j^? (unit vectors)..? lol linear alg
}


void mouseWheel(MouseEvent event) {
  e += -0.07*event.getCount();
}

double getMaxValue(double[] array) {
    double maxValue = array[0];
    for (int i = 1; i < array.length; i++) {
        if (array[i] > maxValue) {
            maxValue = array[i];
        }
    }
    return maxValue;
}

void keyPressed(){
  switch (key){
    case 'y':
      value /= 2;
      break;
    case 'f':
     fS *= 2;
     break;
    case 'x':
      sX++;
      break;
    case 'v':
      linesGone = !linesGone;
      break;
    case 'g':
      gracefulD();
      break;
     case 't':
       sY /= 2;
       value *= 2;
       break;
  }
}

void draw(){
 // frameRate(0.12);
  //println(sY);
 // frameRate(200);
 // transp1 = 255;
  if (max > xCoord.length-2){
    println("audhshdiadshhasuidd");
    stop();
  }
  
  //println("MAX: " + max);
 // println("XSIZE " + xCoord.size());
  scale(scale*e);
  // translate(width/2,height/2);
  follow();
  graphData();
 //translate(width - 800 +max,200+f(max));
  //info();
  max++;
  
 // if (valInc) {
    //gracefulU();
    //sY += 0.01;
    //increaseScale();
//  }
  saveFrame("firstWorkingModel/line-######.png");
}


void increaseValue(double val){
  println(val);
  if (value < val){
  for (float x = 10; x > 0; x--){
    if (value + x/80 > val)
      value = val; //make more smooth l8er!
    else 
    value += x/80;
    }
  }
}

void decreaseValue(double val){
  if (value > 50){
  for (float x = 10; x > 0; x--){
    if (value - x/80 < val)
      value = val; //make more smooth l8er!
    else 
      value -= x/80;
    }
  } 
}

void increaseScale(){
  e += 0.01;
}

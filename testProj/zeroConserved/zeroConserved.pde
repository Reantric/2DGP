import java.util.*;
import java.util.stream.Collectors;

boolean valInc = false;
boolean rescale = false;
boolean linesGone = false;
boolean runOnce = false;

//PShader blur;

double midline;
double doublingFactor;
double xCoord[];
double yCoords[][];

int max = 0;
float scale = 1;
float e = 1;
float xPush = 500;
double value = 100; //DO NOT TOUCH!
Map<Double,double[]> coords = new HashMap<Double,double[]>();
float sX = 1;
float sY = 2; //default : 2
float scaleMultiplier = 2;
float transp1 = 255;
float transp2 = 0;
float boundary = 1;
float fS = 1;
double scalar = scaleMultiplier * value;


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
}

//final float minY = min(IT );

void setup(){
  fetch();
  size(1750,1000,P2D);
  PFont myFont = createFont("Lato",36,true);
  textFont(myFont,36);
  smooth(8);
}

int newWidth = 1200; // i guess i gotta hard code this in :(

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
}

void follow(){
 // print(newWidth);
  //translate(newWidth/2 - sX*max,height/2 - sY*f(max));
  //translate((float) (newWidth/2 - 1/sX*(xCoord[max])),(float) (height/2 + 1/sY*yCoords[max][0]));
  translate((float) (newWidth/2 - (xCoord[max]) + xPush),height/2);
 // stroke(255);
  //circle((float) (newWidth/2 - midline),-70,300);
}

void fadeOut(){
 // println(transp1 + " <<< transp1val ");
    if (transp1 > 1.8){
      for (float t = 25; t > 0; t--){
       // println(transp1);
        transp1 -= t/200;
      }
    } else {
     // println("Ending sY: " + sY);
      linesGone = true;
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

void initGraph(){
  background(0);
  stroke(255);
  float xV = (float) xCoord[max];
  strokeWeight(3);
  //line(0,-50,0,50);
  line(xV-xPush*2.5,0,xV+1000,0);
  strokeWeight(1);
  
  //if value
  for (float a = 0 ; a < xV+1000; a+=200){ //initialize lines and grid lines (x)
      if (a == 0) {
        textSize(25);
        //text(a,8,a-6);
        continue;
      }
      stroke(122,122,122);
      line(a,-10000,a,10000); //x-axis
      textSize(25);
      
      
      if (midline > (height/2)){
        text(Math.round(a/sX),a,height/2 -(float) (midline + 6));
      } else {
      text(Math.round(a/sX),a,-8); // x-axis
    }
  }
  
  //works! --> 
  translate(-(float) (newWidth/2 - xCoord[max]) + xPush,0);
  {
  stroke(255);
  strokeWeight(3);
  line(0,(float) (sY*(-midline)-700),0,(float) -(sY*(-midline)-700));
  stroke(122,122,122);
  strokeWeight(1);
  for (float b = 0; b < (float) 1/sY*(yCoords[max][0] + 900); b += value){ //y
    if (b == 0) continue;
    
   // println(b);
   if (sY > 4*boundary){ //add new ticks!
     println("dsjidsijsdijsdjisd");
     value /= 2;
     boundary *= 4;
     sY = boundary;
   }
   
    if (sY < boundary){ // shrinkinGraph code!
      if (linesGone){
     // println("SY : " + sY + " val: " + value + " bound: " + boundary);
     // println("Ran This!");
    // println("Totally ");
    // stop();
      //sY = boundary;
     // slowIncreaseSY(boundary);
      value = 200/boundary;
      scalar *= 2;
      boundary /= 2;
      linesGone = false;
      transp1 = 255;
      //println("SY : " + sY + " val: " + value + " bound: " + boundary); //Fade takes time to complete, and by the time it does complete, the scale is a little less than what it should be because Fade starts when its less than boundary.
      } else {
        //debug
       // println("B: " + boundary + " sY: " + sY);
      }
      
      
      if (b % scalar != 0){
       // println("Carykh");
        fadeOut();
        fill(255,255,255,transp1);
        stroke(122,122,122,transp1);
      } else {
        fill(255,255,255);
        stroke(122,122,122);
      }
    }
      //rescale = false;

    //println("transp1 VAL: " + transp1);
    essentialsY(b);
    
  }
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

void gracefulU(){
  //println("SY : " + sY + " val: " + value + " bound: " + boundary);
  if (sY > 1 && rescale){
    for (float x = 0; x < 10; x++){
      sY /= 1 + x/8000;
    }
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


void essentialsY(float n){
  line(-10000,(-n)*sY,10000,(-n)*sY);
  if (xCoord[max] > newWidth/2 + xPush){
      text(Math.round(n),(float) (xCoord[max] - newWidth/2 - xPush),(-n-8)*sY);
    } else {
    text(Math.round(n),5,(-n-8)*sY); // y-axis
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

double getTickY(double[] aver){
  //println(aver);
  //stretch out the canvas!
  return 2.3;
}


void graphData(){
  initGraph();
  for (int i = max-600; i < max; i++){ //change 0 to max-constant (keeps program a little efficient!)
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
    //circle(sX*200,sY*  300,40); i^ and j^? (unit vectors)..? lol linear alg
}

void mouseWheel(MouseEvent event) {
  e += -0.07*event.getCount();
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
      valInc = !valInc;
      rescale = true;
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
  
  if (valInc) {
    gracefulU();
    //sY += 0.01;
    //increaseScale();
  }
  //saveFrame("customData2/line-######.png");
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

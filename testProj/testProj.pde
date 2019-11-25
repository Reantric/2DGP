import java.util.*;
import java.util.stream.Collectors;

boolean valInc = false;

//PShader blur;

double midline;

double xCoord[];
double yCoords[][];

int max = 0;
float scale = 1;
float e = 1;
double value = 100;
Map<Double,double[]> coords = new HashMap<Double,double[]>();
float sX = 1;
float sY = 1;


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
  rect((float) (width/2 + xCoord[max]),(float) -(height/2 + midline)  + 2,350,height-4);
  fill(255);
  stroke(0);
  text(sX*xCoord[max]+","+ (yCoords[max][0]), (float) (width/2 + 70 + xCoord[max]),(float) -(midline + 410)); //index yCoords because it is a list of values, adding 1 should make such an insignifcant difference that it is not needed
  //(float) (double) xCoord.get(i), (float) (double) xCoord.get(i+1), (float) yCoord.get(i)[0],(float) yCoord.get(i+1)[0]
}

void follow(){
 // print(newWidth);
  //translate(newWidth/2 - sX*max,height/2 - sY*f(max));
  //translate((float) (newWidth/2 - 1/sX*(xCoord[max])),(float) (height/2 + 1/sY*yCoords[max][0]));
  translate((float) (newWidth/2 - (xCoord[max])),(float) (height/2 + midline));
 // stroke(255);
  //circle((float) (newWidth/2 - midline),-70,300);
}

void graceful(){
  if (value < 70){
    tint(0);
    value = 100;
  }
}

void initGraph(){
  background(0);
  stroke(255);
  float xV = (float) xCoord[max];
  strokeWeight(3);
  line(0,(float) -yCoords[max][0]-700,0,(float) -yCoords[max][0]+700);
  line(xV-800,0,xV+1000,0);
  strokeWeight(1);
  
  //if value
  for (float a = 0 ; a < xV+1000; a+=200){ //initialize lines and grid lines (x)
      if (a == 0) {
        textSize(25);
        //text(a,8,a-6);
        continue;
      }
      line(a,-10000,a,10000); //x-axis
      stroke(122,122,122);
      textSize(25);
      
      
      if (midline > height/2){
        text(Math.round(a/sX),a,height/2 -(float) (midline + 6));
      } else {
      text(Math.round(a/sX),a,-8); // x-axis
    }
  }
  
   
  for (float b = 0; b <  (float) yCoords[max][0] + 900; b += value){ //y
    if (b == 0) continue;
    line(-10000,(-b)*sY,10000,(-b)*sY); //y-axis
    if (xCoord[max] > newWidth/2){
      text(Math.round(b),(float) (xCoord[max] - newWidth/2),(-b-8)*sY);
    } else {
    text(Math.round(b),5,(-b-8)*sY); // y-axis
    }
  }
    
    strokeWeight(4);
    stroke(255,120,120);
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
  for (int i = int(max-600); i < max; i++){ //change 0 to max-constant (keeps program a little efficient!)
    if (i < 0) continue;
    //print(i);
    //sleep(1000);
    //println(yCoord.get(i)[0]);
    //println(max + " " + xCoord.get(i));
    stroke(255,20,20);
    line((float) xCoord[i], -sY* (float) yCoords[i][0], (float) xCoord[i+1], -sY* (float) yCoords[i+1][0]); //MESS WITH THIS !
    stroke(20,255,50);
    line((float) xCoord[i], -sY* (float) yCoords[i][1], (float) xCoord[i+1], -sY* (float) yCoords[i+1][1]);
    
    //filter(BLUR,0);
    }
    midline = (yCoords[max][0] + yCoords[max][1])/2;
    double[] average = new double[2];
    for (int g = 0; g < average.length; g++){
      average[g] = yCoords[max][g] - midline;
    }
    getTickY(average);
    line((float) (xCoord[max] - 500),(float) -midline,(float) (xCoord[max] + 500),(float) -midline);
    //line(xCoord.get(x),yCoord.get(x));
    info();
    noStroke();
    circle((float) xCoord[max],(float) (-sY*yCoords[max][0]),12);
    circle((float) xCoord[max],(float) (-sY*yCoords[max][1]),12);
    circle(sX*200,sY*  300,40);
}

void mouseWheel(MouseEvent event) {
  e += -0.07*event.getCount();
}

void keyPressed(){
  switch (key){
    case 'y':
      sY /= 1.1;
      break;
    case 'x':
      sX++;
      break;
    case 'v':
      valInc = !valInc;
      break;
    case 'g':
      graceful();
  }
}

void draw(){
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
    decreaseValue(50);
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
  e += 0.001;
}

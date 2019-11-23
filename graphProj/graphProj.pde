import java.util.*;
import java.util.stream.Collectors;

PShader blur;

float max = 0;
float scale = 1;
float e = 1;
double value = 100;
List<Double> xCoord = new ArrayList<Double>();
List<double[]> yCoord = new ArrayList<double[]>();
Map<Double,double[]> coords = new HashMap<Double,double[]>();
float sX = 1;
float sY = 1;


void fetch(){
  String[] lines = loadStrings("datas.txt");
  String[] text = lines[0].split(" ");
  //println("there are " + lines.length + " lines");
  for (int i = 1 ; i < lines.length; i++) {
    double[] yVals = new double[text.length]; 
    String[] strHold = lines[i].split(" ");
    xCoord.add(Double.parseDouble(strHold[0]));
    for (int x = 0; x < strHold.length - 1; x++){
      yVals[x] = (Double.parseDouble(strHold[x+1]));
    }
    yCoord.add(yVals);
    coords.put(Double.parseDouble(strHold[0]),yVals);
    //yCoord.add(Arrays.asList().stream().map(n -> n * 3));
  }
  //println("text: " + Arrays.toString(text), "xCoords: " + xCoord, "yCoords: " + yCoord.toString());
  //print("hashMap coords: " + coords);
  //for (Map.Entry<Double,double[]> entry : coords.entrySet()) {
       // System.out.println(entry.getKey() + ":" + Arrays.toString(entry.getValue()));
   // }
}

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

void info(){
  //follow();
  fill(0);
  stroke(255);
  rect((float) (width/2 + sX*xCoord.get(int(max))),(float) -(height/2 + sY*yCoord.get(int(max))[0])  + 2,350,height-4);
  fill(255);
  stroke(0);
  text(xCoord.get(int(max))+","+ (-1*yCoord.get(int(max))[0]),(float) (width/2 + 70 + xCoord.get(int(max))),(float) - (yCoord.get(int(max))[0] + 410)); //index yCoords because it is a list of values, adding 1 should make such an insignifcant difference that it is not needed
  //(float) (double) xCoord.get(i), (float) (double) xCoord.get(i+1), (float) yCoord.get(i)[0],(float) yCoord.get(i+1)[0]
}

void follow(){
 // print(newWidth);
  //translate(newWidth/2 - sX*max,height/2 - sY*f(max));
  translate((float) (newWidth/2 - sX*(xCoord.get(int(max)))),(float) (height/2 + sY*yCoord.get(int(max))[0]));
}

void initGraph(){
  background(0);
  stroke(255);
  strokeWeight(3);
  line(0,-10000,0,10000);
  line(-10000,0,10000,0);
  strokeWeight(1);
  
  for (float a = -1000 ; a < 1000; a+=value){ //initialize lines and grid lines
      if (a == 0) {
        textSize(25);
        //text(a,8,a-6);
        continue;
      }
      line(a,-10000,a,10000); //x-axis
      stroke(122,122,122);
      line(-10000,a,10000,a); //y-axis
      textSize(25);
      
      text(Math.round(a/sX),a,-8); // x-axis
      text(-1*Math.round(a/sY),5,a-8); // y-axis
    }
    
    strokeWeight(4);
    stroke(255,120,120);
}

void graph(){
  initGraph();
  for (double x = max-600; x < max; x+= 0.05){ //actual Graph!
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

void graphData(){
  initGraph();
  for (int i = 0; i < max; i++){ //change 0 to max-constant (keeps program a little efficient!)
    //print(i);
    //sleep(1000);
    //println(yCoord.get(i)[0]);
    //println(max + " " + xCoord.get(i));
    line((float) (double) xCoord.get(i), -1* (float) yCoord.get(i)[0], (float) (double) xCoord.get(i+1), -1* (float) yCoord.get(i+1)[0]);
    //filter(BLUR,0);
    }
    //line(xCoord.get(x),yCoord.get(x));
    info();
}

void mouseWheel(MouseEvent event) {
  e += -0.07*event.getCount();
}

void draw(){
  if (max > xCoord.size()-2){
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
  max += 1;
  //value += 0.01;
  //saveFrame("customData/line-######.png");
}

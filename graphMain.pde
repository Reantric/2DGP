import java.util.*;

float max = 2;
float scale = 1;
float e = 1;
double value = 100;
ArrayList<Double> xCoord = new ArrayList<Double>();
ArrayList<Double> yCoord = new ArrayList<Double>();
ArrayList<String> text = new ArrayList<String>();
Map<Double,Double> coords = new HashMap<Double,Double>();
float sX = 5;
float sY = 3;

void fetch(){
  String[] lines = loadStrings("test.txt");
  text.add(String.join(" ",lines[0].split(" ")));
  //println("there are " + lines.length + " lines");
  for (int i = 1 ; i < lines.length; i++) {
    String[] strHold = lines[i].split(" ");
    coords.put(Double.parseDouble(strHold[1]),Double.parseDouble(strHold[2]));
    xCoord.add(Double.parseDouble(strHold[1]));
    yCoord.add(Double.parseDouble(strHold[2]));
  }
  println("text: " + text, "xCoords: " + xCoord, "yCoords: " + yCoord);
  //print("hashMap coords: " + coords);
  for (Map.Entry<Double,Double> entry : coords.entrySet()) {
        System.out.println(entry.getKey() + ":" + entry.getValue());
    }
}

void setup(){
  fetch();
  size(1750,1000);
  PFont myFont = createFont("Lato",16,true);
  textFont(myFont,36);
  smooth(4);
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
  rect(width/2 + sX*max,sY*f(max) - height/2 + 2,350,height-4);
  fill(255);
  stroke(0);
  text(max+","+ (-1*f(max)),sX*max+900,sY*f(max)-430);
}

void follow(){
 // print(newWidth);
  translate(newWidth/2 - sX*max,height/2 - sY*f(max));
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
  for (int x = 0; x < xCoord.size(); x++){
    sleep(1000);
    println(x);
  }
}

void mouseWheel(MouseEvent event) {
  e += -0.07*event.getCount();
}

void draw(){
  scale(scale*e);
  // translate(width/2,height/2);
  follow();
  graphData();
 //translate(width - 800 +max,200+f(max));
  info();
  max += 0.15;
  //value += 0.01;
  //saveFrame("exponen1.2/line-######.png");
}

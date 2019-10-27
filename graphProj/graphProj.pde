import java.util.*;

static class numjv {

public static ArrayList<Double> linspace(double start, double stop, int n)
{
   ArrayList<Double> result = new ArrayList<Double>();

   double step = (stop-start)/(n-1);

   for(int i = 0; i <= n-2; i++)
   {
       result.add(start + (i * step));
   }
   result.add(stop);

   return result;
  }
  
  
}

float max = 2;
float scale = 1;
float e = 1;
double value = 100;
ArrayList<Double> xCoord = new ArrayList<Double>();
ArrayList<Double> yCoord = new ArrayList<Double>();
ArrayList<String> text = new ArrayList<String>();
ArrayList<Double> curr = numjv.linspace(1,2,3);
Map<Double,Double> coords = new HashMap<Double,Double>();

void fetch(){
  String[] lines = loadStrings("test.txt");
  //println("there are " + lines.length + " lines");
  for (int i = 0 ; i < lines.length; i++) {
    String[] strHold = lines[i].split(" ");
    text.add(strHold[0]);
    coords.put(Double.parseDouble(strHold[1]),Double.parseDouble(strHold[2]));
    xCoord.add(Double.parseDouble(strHold[1]));
    yCoord.add(Double.parseDouble(strHold[2]));
    
  }
  //println("text: " + text, "xCoords: " + xCoord, "yCoords: " + yCoord);
  //print("hashMap coords: " + coords);
  for (Map.Entry<Double,Double> entry : coords.entrySet()) {
        System.out.println(entry.getKey() + ":" + entry.getValue());
    }
}

void setup(){
  fetch();
  size(1200,1000);
  PFont myFont = createFont("Lato",16,true);
  textFont(myFont,36);
  smooth(4);
  
}

float f(double x){
  //stroke(255,15,15);
  return (float) -Math.pow(x,1.2);
}

void follow(){
  translate(width/2 - max,height/2 - f(max));
}

void graph(){
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
      line(a,-10000,a,10000);
      stroke(122,122,122);
      line(-10000,a,10000,a);
      textSize(25);
      text(Math.round(a),5,a-8);
      text(Math.round(a),a,-8);
    }
    
    strokeWeight(4);
    stroke(255,120,120);
    for (double x = max-600; x < max; x+= 0.05){ //actual Graph!
      line((float) x,f(x),(float) (x+0.02),f(x+0.02)); 
      //circle((float) x,30,10); CANT HAVE THIS BECAUSE ITS BEING DRAWN 300 TIMES! 
    }
    noStroke();
    circle((float) max, f(max), 10);
  
}

void mouseWheel(MouseEvent event) {
  e += -0.07*event.getCount();
}

void draw(){
  scale(scale*e);
  // translate(width/2,height/2);
  follow();
  graph();
  text(max+","+-1*f(max),max+420,f(max)-430);
  max += 1;
  //value += 0.01;
  //saveFrame("exponen1.2/line-######.png");
}

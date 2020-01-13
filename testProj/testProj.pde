import java.util.*;
import java.util.stream.Collectors;
import java.text.DecimalFormat;
//just imports it automatically lets goooooooo!

PFont myFont;
PFont nameFont;
DecimalFormat df = new DecimalFormat("#.00");
  
boolean scalingDone = true;
boolean doNotMove = false;
boolean linesGone = false;
boolean runOnce = false;
boolean movingY = false;
boolean fading = false;
boolean debug = false;

//PShader blur;
//FIX 100 multiple when 5'ving!
double midline;
double doublingFactor;
double xCoord[];
double yCoords[][];
String[] names;
double dx;

int max = 0;
int count = 0;
int newWidth = 1400; // i guess i gotta hard code this in :( 
int tailLength = 3000;
int margin = 320;
int startingX = 0;
int startingY = 100;
int startMovingX = 150;

float scale = 1;
float e = 1;
float xPush = 800;
float marking = 100; //how much the y-axis is moved at origin!!!!! 
float slowPushY = 0;
float compensateX = 0;
float transpY = 255;
float transpX = 255;
float endingY;
float textY;
float overtakeM;
float overtakeC;


double relMax = 2;
double value = 100; //DO NOT TOUCH!
double maxVal;
double minVal; 

Map<Double,double[]> coords = new HashMap<Double,double[]>();
//Map<Integer[],String> responses = new HashMap<Integer[],String>();

int[] hexValues = {#ff0000,#00ff00,#00FFFF};
int[] countY;
float sX = 1;
float sY = 2.3; //default : 2
float xValue = 400;
float testorFan = sY*(1/2); //INTEGER DIVISION!
float boundary = sY * (2.0/3); 
float textChange = 100; //thank god for this!
double scalar = 200;

Scaling yAxis = new Scaling(255);
Scaling yAxisVertical = new Scaling(255);
Scaling xAxis = new Scaling(255);
  
void fetch(){
  //println(testorFan);
  String[] lines = loadStrings("datas.txt");
  names = lines[0].split(" ");
  xCoord = new double[lines.length-1];
  yCoords = new double[lines.length - 1][names.length]; //yCoords[n][0]
  //println("there are " + lines.length + " lines");
  for (int i = 1 ; i < lines.length; i++) {
    double[] yVals = new double[names.length];
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
  
  countY = new int[yCoords[max].length];
  //println(yCoords[6][0]);
  //println("text: " + Arrays.toString(text), "xCoords: " + xCoord, "yCoords: " + yCoord.toString());
  //print("hashMap coords: " + coords);
  //for (Map.Entry<Double,double[]> entry : coords.entrySet()) {
       // System.out.println(entry.getKey() + ":" + Arrays.toString(entry.getValue()));
   // }
   
   //0 - 150 >--- maximus of that goes to maxArr
   
   
   //responses.add(new int[],"Ailun is a great man \n, He created air!");
  // responses.add(new {800,1050},"Did you know, that \n ailunMan ");
}

//final float minY = min(IT );

void setup(){
  fetch();
  size(1920,1080,P2D);
  myFont = createFont("Lato",150,true);
  nameFont = createFont("Lato Bold",150,true);
  textFont(myFont);
  smooth(8);
}


float f(double x){
  //stroke(255,15,15);
  return (float) -Math.pow(x,1.4); //x^1.4
}

void funAilun(float x, float y){
  if (xCoord[max] < 240){
    text("Hello and welcome \n to this..?",x,y);
  }
  else if (xCoord[max] > 275 && xCoord[max] < 550){
    text("Simply put, this \n project is about \n graphing data!",x,y);
  }
  else if (xCoord[max] > 600 && xCoord[max] < 1000){
    text("It's not done yet \n but in this video \n I hope to provide \n a basis for this project",x,y);
  }
  else if (xCoord[max] > 1050 && xCoord[max] < 1400)
    text("Did you know \n ailunMan got \n into Harvard!",x,y);
}

void info(){ //must multiply by reciprocal!
  //follow();
  fill(0);
  stroke(255); 
  strokeCap(ROUND);
  rectMode(CORNER);
  textSize(36);
  
  double[] currentValues = Arrays.copyOf(yCoords[max],yCoords[max].length);
 
  Arrays.sort(currentValues);
 // println(currentValues); //i need to get how the indices moved.
   
   
  if (movingY) {
  strokeCap(SQUARE);
  beginShape();
    vertex(width - 350 - marking + compensateX, -(float) (midline + height/2 + 50));
    vertex(width - 350 - marking + compensateX, -(float) (midline + height/2 - 190));
    vertex(width - marking + compensateX, -(float) (midline + height/2 - 190));
    vertex(width - marking + compensateX, -(float) (midline + height/2 + 50));
  endShape();
  strokeCap(ROUND);
  //rect(width - 350 - marking,(float) -(midline + height/2),350,height-4);
    
    fill(255);
    textSize(34);
    text("        Compression Factor:",width-200-marking + compensateX,-(float) (-50 + midline+height/2 + 0.13/sY));
   // funAilun(width-170-marking + compensateX,-(float) (midline-height/2 + 540));
    textSize(38 + 0.4/sY);
    fill(255,255 - 16/sY,255 - 16/sY);
    text(df.format(1/sY),width-170-marking + compensateX,-(float) (midline+height/2 - 105));
  
  } else {
  strokeCap(SQUARE);
  beginShape();
    vertex(width - 350 - marking + compensateX, -height+1);
    vertex(width - 350 - marking + compensateX, -height+240);
    vertex(width - marking + compensateX, -height+240);
    vertex(width - marking + compensateX, -height+1);
  endShape();
  strokeCap(ROUND);
    //rect(width - 350 - marking, -height + 50, 350, height-50)
    
    fill(255);
    textSize(34);
    text("        Compression Factor:",width-200-marking + compensateX,-(height - 100 + 0.13/sY));
  //  funAilun(width-170-marking + compensateX,-480);
    textSize(38 + 0.4/sY);
    fill(255,255 - 16/sY,255 - 16/sY);
    text(df.format(1/sY),width-170-marking + compensateX,-height + 155);
  }
  
  //fill(255);
 // text(sX*xCoord[max]+","+ (yCoords[max][0]), (float) (width/2 + 70 + xCoord[max] - xPush),(float) -(midline + 410)); //index yCoords because it is a list of values, adding 1 should make such an insignifcant difference that it is not needed
  //(float) (double) xCoord.get(i), (float) (double) xCoord.get(i+1), (float) yCoord.get(i)[0],(float) yCoord.get(i+1)[0]
  textFont(nameFont);
  textSize(32);
 for (int c = 0; c < yCoords[max].length;c++){
      fill(hexValues[c]);
      //check();
      textAlign(LEFT);
      for (int m = 0; m < yCoords[max].length;m++){ //hmmm interessant!
        //println(textY);
        if (m == c) continue;
        
        
        if (Math.abs(yCoords[max][m] - yCoords[max][c]) < 30/sY){

          if (yCoords[max][c] > yCoords[max][m]){
            
         

           textY = (float) yCoords[max][c] + 2/sY;

           if (yCoords[max+15][m] > yCoords[max+15][c]){
               countY[c]++;
               println(Arrays.toString(countY));
              //slowly move my man C DOWN!!!! just switch with m lmao
              
              if (textY - 3/sY * countY[c] < yCoords[max+15][c] + 2/sY){
                textY = (float) (yCoords[max+15][c] + 2/sY);
              } else {
              textY -= 3/sY * countY[c]; 
              }//keeps getting reset after every loop
              
              
            }
            
            
          } else { // m > c
             
              
              textY = (float) yCoords[max][m] - 28/sY; //25 less!

              if (yCoords[max+15][c] > yCoords[max+15][m]){
              //slowly move my man C UP! to where it b e l o n g s !
          // ////   
          //   if (textY + 3/sY * countY[m] > yCoords[max+15][m] - 28/sY){
               //textY = (float) (yCoords[max+15][m] - 28/sY);
           //  } else {
             println("I EXIST!");
             textY += 3/sY * countY[m];
             //}
             
            }

          }
        
        break;
          
        } else {
         // if (countY[c] != 0) countY[c] = 0;
          textY = (float) yCoords[max][c] + 2/sY;
        }
      }
       if (textY < 10/sY){
         textY  = 10/sY;
       }
       text(names[c] + " (" + Math.round(yCoords[max][c]) + ")",(float) xCoord[max] + 40,-sY*textY);
       
    }
    //countY = new int[yCoords[max].length];
    textFont(myFont);
    textAlign(CENTER);
  
  fill(255);
  
  

}

void follow(){
  if (midline < height/2 - 50){
    slowPushY = height - 50;
    movingY = false;
  }
  else {
    slowPushY = (float) (height/2 + midline);
    movingY = true;
  }
  
  if (xCoord[max] > newWidth - marking + startMovingX){ //thats perfect! <--- Ok, now what?
      translate((float) (newWidth - xCoord[max] + startMovingX),slowPushY); //y = (float) (height/2 + midline)
      compensateX = (float) (xCoord[max] - newWidth + marking - startMovingX);
      margin = 320 + 50;
   } else {
    translate((float) (marking),slowPushY); //200, 300! //y = height - 50 //(---> 125)
    margin = 320; //might be a bit low...?
  }
}

boolean slowAdjustY(){
  if (slowPushY < midline - height/2 + 50){
  //println("spY: " + slowPushY);
  slowPushY += ((float) (midline - height/2 + 50))/100;
  return false;
  }
 // stop();
  return true;
 
 
}

int floorAny(double jjfanman, double val){
  return (int) (val*Math.floor(jjfanman/val));
}

void initGraph(){
  background(0);
  stroke(255);
  float xV = (float) xCoord[max] + 2000;
  strokeWeight(3);
 // line(0,(float) (sY*(-midline)-700),0,(float) -(sY*(-midline)-700));
 if (movingY){
   line(0,-sY*(float) (midline/sY + height/(2*sY)),0,-sY*(float) (midline/sY - height/(2*sY)) < 0 ? -sY*(float) (midline/sY - height/(2*sY) + 5) : 0);
   endingY = (float) (midline/sY + height/(2*sY));
 } else {
   line(0,0,0,-(height-50)); //50 is the margin-up
   endingY = (height-50) * (float) (1/sY);
   //println(endingY);
 }
  //line(xV-xPush*2.5,0,xV+1000,0);
  line(0,0,xV,0);
  strokeWeight(3); //xLines stroke!
  strokeCap(SQUARE);

  //if value
  //println(starting);
  for (float a = startingX; a < xV; a+=xValue){ //initialize lines and grid lines (x)
      if (a <= 0) {
        startingX = floorAny(xCoord[max] - newWidth + marking,xValue);
        textSize(25);
        //text(a,8,a-6);
        continue;
      }
      
      if (a < xCoord[max] - newWidth + textChange - startMovingX + 10){ //id: fading
        //begin fading!
        stroke(122,122,122, xAxis.fadeOut(11));
       // fill(255, xAxis.fadeOut(11));
      } else {
        stroke(122,122,122);
       // fill(255);
      }
      
      if (xAxis.isFinished()) {
        xAxis.reset();
        startingX += 200;
      }
     
      //fadeOut();
      
      if (midline > height/2 - 50 && movingY){
          //text(showText(a).indexOf(".") < 0 ? showText(a) : showText(a).replaceAll("0*$", "").replaceAll("\\.$", ""),a-16,height/2 - (float) (midline + 6));
        line(a,-10000,a,(float) (height/2 - midline) - 50);
      } else {
      //text(showText(a).indexOf(".") < 0 ? showText(a) : showText(a).replaceAll("0*$", "").replaceAll("\\.$", ""),a-16,30); // x-axis
      line(a,-10000,a,-2);
    }
    
  }
  
  for (float b = startingY; b < endingY; b += value){ //now we get a value problem, knew it was hiding somewhere!
    if (b == 0) continue;
   // println(b);
   if (sY > 4*boundary){ //add new ticks!
     println("dsjidsijsdijsdjisd");
     value /= 2;
     boundary *= 4;
     sY = boundary;
   }
   stroke(250,22,120);
   strokeWeight(3); //yAxis strokes
//  line(-700,-(float) midline,700,-(float) midline); midlineTestLine //hmmm maybe this isnt needed!
   stroke(122,122,122);
   
  //  println(midline/sY + height/(2*sY));
    if (sY < boundary){ // shrinkinGraph code!
      
      if (b % scalar != 0){ 
        
        //  fill(255,255,255,yAxis.fadeOut(1.6));
          stroke(122,122,122,yAxis.fadeOut(1.6));
       
      } 
      else {
        //  fill(255,255,255);
          stroke(122,122,122);
      }
    }
    
    //println("VALUE: " + value + " POS: " + ((float) midline/sY + height/(2*sY)-b));
      //rescale = false;

    //println("transp1 VAL: " + transp1);
   
  /*  if (b < midline - height/2 + 100 && !fading){
        println("xaviD " + b);
        //startingY += value;
        fill(255,255,255,yAxisVertical.fadeOut(5));
        stroke(122,122,122,yAxisVertical.fadeOut(5));
    } else {
      fill(255,255,255,transp);
      stroke(122,122,122,transp);
    } 
   
   if (yAxisVertical.isFinished()){
     startingY += value;
     yAxisVertical.reset();
   } */
   
    essentialsY(b);
    
  }
    
    if (Integer.parseInt(Double.toString(scalar).substring(0,1)) == 5){
    //fill(255,255,255,yAxis.fadeIn());
    stroke(122,122,122,yAxis.fadeIn());
    for (int c = floorAny(startingY,scalar); c < endingY; c += scalar){ //cant be exactly startingY now can it?
       if (c == 0) continue;
       if (xCoord[max] > newWidth - textChange + startMovingX){
          line((float) xCoord[max] - (newWidth - textChange + startMovingX),(-c)*sY,10000,(-c)*sY); // < ---- adjusts the 1280 - value!
      } else {
        line(-10,(-c)*sY,10000,(-c)*sY);
      }
    }
}
      
    //strokeWeight(4);
   // stroke(255,120,120);
    //strokeCap(ROUND);
}

String showText(float a){
  if (Math.round(a/sX) >= 1000){
    String s = Float.toString((a/sX)/1000);
    return s.indexOf(".") < 0 ? s : s.replaceAll("0*$", "").replaceAll("\\.$", "") + "K";
  } 
  String s = Integer.toString(Math.round(a/sX));
  return s.indexOf(".") < 0 ? s : s.replaceAll("0*$", "").replaceAll("\\.$", "");
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


void linDec(double val){ //make quadratic :?
  float distance = sY - (float) val;
 // println("dist: " + distance);
  if (sY > val){
    if (sY - distance/50 < val){
      sY = (float) val;
    } else {
    sY -= distance/50;
    }
    
  } else {
    scalingDone = true;
    //println("hiFinished!");
  }
  
}



void instaChange(double val, boolean downwards){
  //  println("sY: " + sY + " val " + val + " relMax " + relMax);
    if ((sY/val <= 1.0002 && val / 1.15 < boundary) && !downwards){ //ideally sY and val turn out to be equal. db rounding error
      linDec(boundary*0.96);
    } else {
    
      if (!scalingDone && (downwards || val < boundary*2)){
          sY = (float) val;
        } else {
          scalingDone = true;
        }
    }
}

void essentialsY(float n){
  //line(0,(-n)*sY,10000,(-n)*sY);
//  if (midline < 50) return;
  if (xCoord[max] > newWidth - textChange + startMovingX){
     //println("testor123");
    //  text(showText(n),(float) (xCoord[max] - newWidth/2 - xPush),(-n+5)*sY);
      line((float) xCoord[max] - (newWidth - textChange + startMovingX),(-n)*sY,10000,(-n)*sY); // < ---- adjusts the 1280 - value!
    } else {
   // text(showText(n),-60,(-n + 5)*sY); // y-axis
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


float sumMid(){
  //assuming no jagged arrays
  float s = 0;
  int n = yCoords[max].length;
  n = 2;
  for (int i = 0; i < n; i++){
    if (yCoords[max][i] < 0) continue;
    s += yCoords[max][i];
  }
  
  return s/n;
}

void graphData(){ //max++ is intrinsic!
  autoScale(); //decor! 
  //initGraph();
   //Arrays.sort(yCoords[max]);
  for (int i = max-tailLength; i < max; i++){ //change 0 to max-constant (keeps program a little efficient!) //advances 1 every time it is redrawn 
    if (i < 0) continue;
    //print(i);s
    //sleep(1000);
    //println(yCoord.get(i)[0]);
    //println(max + " " + xCoord.get(i));
    strokeWeight(5);
    
    for (int c = 0; c < yCoords[i].length; c++){ //could put text into this one too, but that should go into info because they cannot overlap! 
    //or who knows might change my mind for efficiency reasons!
      stroke(hexValues[c]);
      line((float) xCoord[i], -sY* (float) yCoords[i][c], (float) xCoord[i+1], -sY* (float) yCoords[i+1][c]);
      noStroke();
      fill(255);
      circle((float) xCoord[max],(float) (-sY*yCoords[max][c]),12);
    }
   // stroke(255,20,20);

    //line((float) xCoord[i], -sY* (float) yCoords[i][0], (float) xCoord[i+1], -sY* (float) yCoords[i+1][0]); //MESS WITH THIS !
   // stroke(20,255,50);
   // line((float) xCoord[i], -sY* (float) yCoords[i][1], (float) xCoord[i+1], -sY* (float) yCoords[i+1][1]);
   // stroke(20,50,255);
   // line((float) xCoord[i], -sY* (float) yCoords[i][2], (float) xCoord[i+1], -sY* (float) yCoords[i+1][2]);
    //filter(BLUR,0);
    }
    info();
   // midline = sY * ((yCoords[max][0] + yCoords[max][1])/2); //intrinsic!
  /// */
    /*double[] average = new double[2];
    for (int g = 0; g < average.length; g++){
      average[g] = yCoords[max][g] - midline;
    }
    getTickY(average);
    */
        //fade();
    //line(xCoord.get(x),yCoord.get(x));
   // noStroke();
   // line((float) (xCoord[max] - 500),(float) -midline,(float) (xCoord[max] + 500),(float) -midline);
    
   // circle((float) xCoord[max],(float) (-sY*yCoords[max][2]),12);
  // getScaleY(yCoords[max]);
    
    blackBox();
    midline = sY*sumMid();
    //circle(sX*200,sY*  300,40); i^ and j^? (unit vectors)..? lol linear alg
}

void autoScale(){
   // line((float) xCoord[max] - width/2 - 15,-500,(float) xCoord[max] - width/2 - 15,500);
    maxVal = getMaxValue(yCoords[max]);
    if (maxVal > (midline + margin)/sY){ //very important! not changing the coordinate plane, just the values that objects take up in that coordinate plane!
     // println("Diff: " + (maxVal - (midline - margin)/sY)); 
      sY = (float) ((midline+margin)/maxVal);
     // println("BOUNDARY: " + boundary + " SY: " + sY + " FREQ: " + (2));
    }
   // if ((midline + margin)/maxVal < relMax && moving){
     // println("ML : " + ((midline + 100)/maxVal) + " rM: " + relMax + "sY: " + sY + "xCoord : " + xCoord[max]);
  //    relMax = (midline + margin)/maxVal;
  //    instaChange(relMax,false);
 //  } //else println("relMax: " + relMax + " b: " + boundary + " dx " + dx);
   initGraph();
    //relMax = (midline + margin)/yCoords[max][0];
  /* stroke(255);
    strokeWeight(10);
   line(-700,-(float) (midline - margin),700,-(float) (midline - margin));
   line(-700,-400,700,-400); //keeps the line at a constant place but not static in terms of the graph
    line(-700,-(float) (midline+margin), 700, -(float) (midline+margin));
    text("MaxVal : " + maxVal + " minVal: " + minVal, 200, -(float) (midline + 340));
    */
  /* else if ((midline + 100)/maxVal > relMax){
    // println("halleloyaaa");
    // stop();
     //relMax = (midline + 100)/maxVal;
    // instaChange(relMax,false);
   } else if (sY / 1.15 < boundary){
     linDec(boundary*0.96);
   }*/
   
     //println("ML : " + ((midline + 100)/maxVal) + " rM: " + relMax + "sY: " + sY + "xCoord : " + xCoord[max]);
  //put all this into a function!
    //println(relMax);
  //  instaChange(relMax);
     
     
    if (sY*maxVal > midline + margin){
      scalingDone = false;
      //text((float) (1/sY * midline), -600, -(float) (midline + 340));
    }
    
}

void blackBox(){ //WORKS, DO MORE TESTING WITH IT LATER!!!!
  textSize(30);
  fill(0);
  noStroke();
  if (movingY){
  rect((float) -80,-56 + (float) (height/2 - midline),(float) xCoord[max] + 1800,70); //horizontalRect
  }
  
  if (xCoord[max] > newWidth - textChange + startMovingX){
    rect((float) (xCoord[max] - newWidth - startMovingX),-(float) (midline + height - 50),90,(float) (midline + height)); //verticalRect
  }
  fill(255);

  for (float a = startingX; a < xCoord[max] + 1800; a+=xValue){ //initialize lines and grid lines (x)
      if (a <= 0) {
        startingX = floorAny(xCoord[max] - width/2 - 50,xValue);
       // textSize(25); //oh this thing stops getting run lol
        //text(a,8,a-6);
        continue;
      }
     
     if (a < xCoord[max] - newWidth + textChange + 10){
     //stroke(122,122,122,xAxis.getTransp());
     fill(255, xAxis.getTransp());
     } else {
        stroke(122,122,122);
        fill(255);
      }
     
    textAlign(CENTER);
    
    if (midline > height/2 - 50 && movingY){
            text(showText(a).indexOf(".") < 0 ? showText(a) : showText(a).replaceAll("0*$", "").replaceAll("\\.$", ""),a-16,height/2 - (float) (midline + 15)); //removes all .0s!
        } else {
        text(showText(a).indexOf(".") < 0 ? showText(a) : showText(a).replaceAll("0*$", "").replaceAll("\\.$", ""),a-16,30); // x-axis
      }
    }
  
  for (float b = startingY; b < endingY; b += value){
    if (b == 0 || b*sY < midline - height/2 + 54){//erase y-axis ticks before they hit the rect!
      continue;
    }
    
    //startingY = 0;
   // println(startingY);
    
   // if () 
    //println("XD: " + ((-b+5)*sY) + " ZAV: " + (height/2 - midline + 50));
      //continue;
    
    if (b % scalar != 0){ //weeding stage!
       // fadeOut(1)
        fill(255,255,255,yAxis.getTransp());
       // stroke(122,122,122,yAxis.getTransp());
       
      } 
      else {
          fill(255,255,255);
          stroke(122,122,122);
      }
      
     textAlign(CENTER,CENTER);
    if (xCoord[max] > newWidth - textChange + startMovingX){
    // println("testor123");
      text(showText(b),(float) (xCoord[max] - (newWidth - textChange + startMovingX) - 50),-b*sY);
      //-50 + something
    } else {
    text(showText(b),-50,-b*sY); // y-axis
    }
    
   //   startingY = (int) (floorAny((midline - height/2 + 60)/sY,scalar)) > 0 ? (int) (floorAny((midline - height/2 + 60)/sY,scalar)) : 0; 
      startingY = floorAny((midline - height/2 + 60)/sY,value) + (int) value;
  }
  
  if (Integer.parseInt(Double.toString(scalar).substring(0,1)) == 5){
          fill(255,255,255,yAxis.fadeIn());
          //println(yAxis.fadeIn() * (255.0f/122));
          for (int c = floorAny(startingY,scalar); c < endingY; c += scalar){ //cant be exactly startingY now can it?
              if (c == 0) continue;
              if (xCoord[max] > newWidth - textChange + startMovingX){
              // println("testor123");
                text(showText(c),(float) (xCoord[max] - (newWidth - textChange + startMovingX) - 50),-c*sY);
                //-50 + something
              } else {
                text(showText(c),-50,-c*sY); // y-axis
            }
          }
      }
      
  if (yAxis.isFinished()){
    //  println("startY: " + startingY + " newScal: " + scalar + " b: " + b + " value: " + value); //hmmmmm!!!
      value = scalar;
      //println("current value: " + value + " current start: " + startingY + " work: " + (startingY % value == 0));
      if (Integer.parseInt(Double.toString(value).substring(0,1)) == 2){
        println("fanman1: " + scalar);
        scalar *= 2.5; //integer division again lol
        boundary /= 2;
      }
      
      else if (Integer.parseInt(Double.toString(value).substring(0,1)) == 5){ 
        scalar *= 2;
        boundary /= 2.5;
      } 
      
      else {
      
      scalar *= 2;
      boundary /= 2;
      
      }
      yAxis.reset();
      //transpYScale = 255;
      //println("SY : " + sY + " val: " + value + " bound: " + boundary); //Fade takes time to complete, and by the time it does complete, the scale is a little less than what it should be because Fade starts when its less than boundary.
      }  
      startingY = floorAny((midline - height/2 + 60)/sY,value) + (int) value;
      
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

double getMinValue(double[] array) {
    double minValue = array[0];
    for (int i = 1; i < array.length; i++) {
        if (array[i] < minValue) {
            minValue = array[i];
        }
    }
    return minValue;
}

void keyPressed(){
  switch (key){
    case 'y':
      value /= 2;
      break;
    case 'f':
    // fS *= 2;
     break;
    case 'x':
      debug = true;
      frameRate(2);
      break;
    case 'v':
      linesGone = !linesGone;
      break;
    case 'g':
      //gracefulD();
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
  //saveFrame("testAilun/line-######.png");
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

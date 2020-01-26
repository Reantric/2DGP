import java.util.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.*;
import java.sql.Timestamp;
import java.util.Collections;
//just imports it automatically lets goooooooo!

//works at 20k

NumberFormat dollar = NumberFormat.getCurrencyInstance(Locale.FRANCE);
LocalDate date;

PFont myFont;
PFont nameFont;
DecimalFormat df = new DecimalFormat("#.00");
Calendar cal = Calendar.getInstance();
String[] days = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
String[] months = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec"};
boolean scalingDone = true;
boolean doNotMove = false;
boolean linesGone = false;
boolean runOnce = false;
boolean movingY = false;
boolean fading = false;
boolean debug = false;
boolean topDog = true;

//PShader blur;
//FIX 100 multiple when 5'ving!
double midline;
double doublingFactor;
double xCoord[];
double yCoords[][];
double textCoords[];
String[] names;
Coord[] coordObj;


int rowLength;
int max = 825;
int count = 0;
int newWidth = 1400; // i guess i gotta hard code this in :( 
int tailLength = 3000;
int margin = 320;
int startingY = 100;
int startMovingX = 110; //lovemyself! <-- def 150
int marginY = 70; ///70
int textMovementY = -56; // amount text is moved from canvas line x=0

float scale = 1;
float e = 1;
float xPush = 800;
float marking = 100; //how much the y-axis is moved at origin!!!!! default: 100
float slowPushY = 0;
float compensateX = 0;
float transpY = 255;
float transpX = 255;
float endingY;
float textY;
float overtakeM;
float overtakeC;
float xV;
float yChange;

double origin;
double relMax = 2;
double value = 100 * (1.0); //DO NOT TOUCH! nah //value is 200, sY is 1 if value is 500, sY has to be 0.4 but can be anything less???
double maxVal;
double minVal; 
double cut;
double invariant = 760;

Map<Double,double[]> coords = new HashMap<Double,double[]>(); //04:17:02
//Map<Integer[],String> responses = new HashMap<Integer[],String>();

int[] hexValues = {#00FFFF,#ff0000,#00ff00,#966FD6,#ffff00,#ffc0cb,#008080,#d4560d};
int[][] countY;
PImage[] images;
float sX = 1 / (19723.0); //default 20.0k
float xValue = 400 * (19723.0); //seconds!
int startingX = (int) xValue;
float sY = 2.3; //default : 2.3
float testorFan = sY*(1/2); //INTEGER DIVISION!
//float boundary = sY * (2.0/3); //this is a problem
float boundary = (sY * (2.0/3)); //comment out after!
float textChange = 120; //thank god for this! default: 100
double scalar = value*2; //lol

Scaling yAxis = new Scaling(255);
Scaling yAxisVertical = new Scaling(255);
Scaling xAxis = new Scaling(255);
  
void fetch(){
  sY = 0.43;
  value = 500;
  scalar = 1000;
  boundary = 0.32;
  //println(testorFan);
  String[] lines = loadStrings("datas.txt");
  names = lines[0].split(" ");
  /*for (int n = 0; n < names.length; n++){
    names[n] = names[n].replace("_"," ");
  }*/
  
  xCoord = new double[lines.length-1];
  yCoords = new double[lines.length - 1][names.length]; //yCoords[n][0]
  textCoords = new double[names.length];
  coordObj = new Coord[names.length];
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
  
  countY = new int[yCoords[max].length][yCoords[max].length];
  images = new PImage[yCoords[max].length];
  for (int i = 0; i < images.length; i++){
    images[i] = loadImage(names[i].toLowerCase()+".png"); //all files must be saved in lowercase! remember this !!!!!!!
  }
  //println(yCoords[6][0]);
  //println("text: " + Arrays.toString(text), "xCoords: " + xCoord, "yCoords: " + yCoord.toString());
  //print("hashMap coords: " + coords);
  //for (Map.Entry<Double,double[]> entry : coords.entrySet()) {
       // System.out.println(entry.getKey() + ":" + Arrays.toString(entry.getValue()));
   // }
   
   //0 - 150 >--- maximus of that goes to maxArr
   for (int f = 0; f < textCoords.length; f++){
    textCoords[f] = yCoords[0][f] + 1/sY;
    coordObj[f] = new Coord(yCoords[0][f], hexValues[f], names[f], images[f], yCoords[10][f]);
  //  useComplement[f] = true;
  }
   Arrays.sort(coordObj);
   origin = xCoord[0]; //O(1)
   cut = origin;
   println("Origin: " + origin);
   println(xCoord.length);
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
//  hint(ENABLE_STROKE_PURE);
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

void leaderboard(){
 // println(Arrays.toString(textCoords));
// stroke(255);
  fill(255);
  textSize(42);
  int maxInd = rowLength - 1;
  Coord maxObj = coordObj[rowLength-1]; //check if.. names change:?:?:?:?:?:?:?:?:?:?:?
  if (maxObj.name != names[getIndexOfMax(yCoords[max+1])]){
    //ahhh this one might be a little...tough..? better way im sure.>>!
    //stop();
    cut = xCoord[max];
  }
  
    //UNIX TS:
    date = Instant.ofEpochMilli((long) xCoord[max] * 1000).atZone(ZoneId.systemDefault()).toLocalDate();

    //cal.setTimeInMillis((long) xCoord[max] * 1000);
  //  println(date);
   
    //date = LocalDateTime.ofEpochSecond((long) xCoord[max],0,ZoneOffset.UTC);
  //  println((long) xCoord[max] * 1000);
   // println(cal.get(Calendar.YEAR));
   // println((long) xCoord[max]);
  
    
    image(maxObj.img,260+compensateX,-height+130 + yChange,160,160); //acount for x--> ALSO MAYBE TRY CATCH THIS?
    text("Leader: ",100+compensateX,-height + 120 + yChange);
    
    textAlign(LEFT);
    textFont(nameFont);
    textSize(36);
    
    text("For " + Math.round(xCoord[max] - cut)/86400 + " days", 360+compensateX, -height + 190 + yChange);
    

    textSize(50);
    text(""+maxObj.name.replace("_"," ") + " (" + Math.round(maxObj.yValue) + ")",360 + compensateX,-height + 135 + yChange);


    textAlign(CENTER);

}

int getIndexOfMax(double[] john){
  double largest = john[0];
  int index = 0;
  for (int i = 1; i < john.length; i++){
    if (john[i] > largest){
      largest = john[i];
      index = i;
    }
  }
  return index;
  
}

int getClosestPair(int a){
  double c = getMaxValue(yCoords[max]) + 5; //thats a feelsbad LOL
  int r = -1;
  for (int i = 0; i < yCoords[max].length; i++){
    if (i == a) continue;
    if (yCoords[max][i] > yCoords[max][a] && yCoords[max][i] < c){ //where 2 !< -2 ;D
      c = yCoords[max][i];
      r = i;
    }
  }
  return r;
}

void info(){ //must multiply by reciprocal!
  //follow();
  leaderboard();
  fill(0);
  stroke(255); 
  strokeCap(ROUND);
  rectMode(CORNER);
  textSize(36);
  
 // println(currentValues); //i need to get how the indices moved.

  strokeCap(SQUARE);
  beginShape();
    vertex(width - 350 - marking + compensateX, -height+21 + yChange);
    vertex(width - 350 - marking + compensateX, -height+261 + yChange);
    vertex(width - marking + compensateX, -height+261 + yChange);
    vertex(width - marking + compensateX, -height+21 + yChange);
  endShape();
  strokeCap(ROUND);
    //rect(width - 350 - marking, -height + 50, 350, height-50)
    
    fill(255);
    textSize(34);
    text("        Current Date:",width-200-marking + compensateX,-(height - 120) + yChange);
  //  funAilun(width-170-marking + compensateX,-480);
    textSize(38);
    String strMonth = date.getMonth().toString().substring(0,3);
    text("" + strMonth.substring(0,1) + strMonth.substring(1,3).toLowerCase() + " " + date.getDayOfMonth() + ", " + date.getYear(),width-170-marking + compensateX,-height + 190 + yChange);
  
  //fill(255);
 // text(sX*xCoord[max]+","+ (yCoords[max][0]), (float) (width/2 + 70 + xCoord[max] - xPush),(float) -(midline + 410)); //index yCoords because it is a list of values, adding 1 should make such an insignifcant difference that it is not needed
  //(float) (double) xCoord.get(i), (float) (double) xCoord.get(i+1), (float) yCoord.get(i)[0],(float) yCoord.get(i+1)[0]
  textFont(nameFont);
  textSize(32);
  
  
  //textCoords[rowLength-1] = coordObj[rowLength - 1].yValue + 1/sY; //aka maximum of the list!
  
  for (int c = 0; c < rowLength; c++){ //first init..:?
    if (coordObj[c].yValue < 0) continue;
    
    textCoords[c] = coordObj[c].yValue + 1/sY; //initialize TC properly!
  }

  for (int c = rowLength - 2; c >= 0; c--){
   
   int k = 3;
   if (coordObj[c].yValue < 0) continue;
   
   if (textCoords[c+1] - textCoords[c] < 34/sY){ ///oh shit L O L o_O
     if (c == rowLength - 2)
       textCoords[c] = textCoords[c+1] - 33/sY;
     else
       textCoords[c] = textCoords[c+1] - 33/sY - k/sY*countY[c+1][c+2]; //if only there was a way to keep tc[c+1] - 33/sY frozen for long enough so that the transition has finished...
     
     if (coordObj[c].futureY > coordObj[c+1].futureY){
       countY[c][c+1]++;
       double changeAmt = k/sY * countY[c][c+1];
       textCoords[c] += changeAmt;
       textCoords[c+1] -= changeAmt;
     } else {
       if (countY[c][c+1] > 9) countY[c][c+1] = 0;
     }
   }
  // textCoords[c] = coordObj[c].yValue + 1/sY; //works!
 //  textCoords[c] = yCoords[max][c] + 1/sY; //doesn't work!

      
  }
   
 for (int c = 0; c < rowLength; c++){ //doesnt work because richard comes before andy! a change from andy does not affect richard!
   if (coordObj[c].getYCoord() < 0) continue;
      fill(coordObj[c].hexCode);
      //check();
    //  int k = 3;
      textAlign(LEFT);
     // int m = getClosestPair(c); // <---THIS! IS PROBLEMgets closest neighbor thats ABOVE IT! (if -1, yer top dawggg)


      textY = (float) textCoords[c];
  
      //}
       if (textY < 10/sY){
         textY = 10/sY;
       }
       imageMode(CENTER);
       image(coordObj[c].img,sX* (float) (xCoord[max] - origin) + 35,-sY*textY - 10,30,30); //hmm..?
       //println("SY: " + sY);
       text(coordObj[c].name.replace("_"," ") + " (" + Math.round(coordObj[c].yValue) + ")",sX* (float) (xCoord[max] - origin) + 60,-sY*textY); //shit made it SO CONFUSING
       
    }
    //countY = new int[yCoords[max].length];
    textFont(myFont);
    textAlign(CENTER);
  
  fill(255);
  
  

}



void initObjArr(){ //ok i think i know da issue!
   rowLength = yCoords[max].length;
   for (int c = 0; c < rowLength; c++){
    // if (yCoords[max][c] < 0) continue; //maybe:? this is really nice :'( whatever IDGAF
       coordObj[c] = new Coord(yCoords[max][c],hexValues[c],names[c], images[c], yCoords[max+10][c]);
   }
   
   Arrays.sort(coordObj); //Collections.reverseOrder()
  // for (int j = 0; j < rowLength; j++){
    // println(coordObj[j].toString());
   //}
   
}

void follow(){

  //pushPop = 220/sY;
  if (midline < height/2 - marginY){
    slowPushY = height - marginY;
    movingY = false;
    yChange = 0;
    
  }
  else {
    slowPushY = (float) (height/2 + midline);
    movingY = true;
    yChange = -(float) (midline - height/2 + marginY);
  }

  if (sX*(xCoord[max] - origin) > newWidth - marking + startMovingX){ //thats perfect! <--- Ok, now what?
      translate((float) (newWidth - sX*(xCoord[max] - origin) + startMovingX),slowPushY); //y = (float) (height/2 + midline) refer back to original gitHub
      compensateX = (float) (sX*(xCoord[max] - origin) - newWidth + marking - startMovingX);
      margin = 340;
   } else {
    translate((float) (marking),slowPushY); //200, 300! //y = height - 50 //(---> 125)
    margin = 350; //might be a bit low...?
  }

}

boolean slowAdjustY(){
  if (slowPushY < midline - height/2 + marginY){
  //println("spY: " + slowPushY);
  slowPushY += ((float) (midline - height/2 + marginY))/100;
  return false;
  }
 // stop();
  return true;
 
 
}

int floorAny(double jjfanman, double val){
  return max((int) (val*Math.floor(jjfanman/val)),0);
}

void initGraph(){
  background(0); //<--- prob this idk
  //if (debug)
    //println("" + xCoord[max] + " " + date.getMonth());
  strokeWeight(8);
  stroke(255);
  //line(0,-(float) (220)/sY + yChange,xV,-(float) (220)/sY + yChange);
 // line(0,-(float) (760) + yChange,xV,-(float) (760) + yChange); //midline! maxVal * sY < 760 :DD::D:D:D:D if maxVal*sY > 760, 760/maxVal
  
  stroke(255);
  xV = (compensateX + width)/sX;
  strokeWeight(3);
 // line(0,(float) (sY*(-midline)-700),0,(float) -(sY*(-midline)-700));
 if (movingY){ //change to max()
   line(0,-sY*(float) (midline/sY + height/(2*sY)),0,-sY*(float) (midline/sY - height/(2*sY)) < 0 ? -sY*(float) (midline/sY - height/(2*sY) + 5) : 0);
   endingY = (float) (midline/sY + height/(2*sY));
 } else {
   line(0,0,0,-(height-marginY)); //50 is the margin-up
   endingY = (height-marginY) * (float) (1/sY);
   //println(endingY);
 }
  //line(xV-xPush*2.5,0,xV+1000,0);
  //println(-sY*(float) (midline - height/2 + marginY));
  line(0,0,xV,0); //
  strokeWeight(3); //xLines stroke!
  strokeCap(SQUARE);

  //if value
  //println(starting);
  for (float a = startingX; a < xV; a+=xValue){ //initialize lines and grid lines (x)
      if (a <= 0) {
       // startingX = floorAny(sX*(xCoord[max] - origin) - newWidth + marking,xValue); //default: xValue keeps reverting to 750 (maybe -origin)
        textSize(25);
        //text(a,8,a-6);
        continue;
      }
      
      if (a < xCoord[max] - origin - (newWidth - textChange + startMovingX - 15)/sX){ //id: fading default +15 //26 from 120-94 :(
        //begin fading!
        stroke(122,122,122, xAxis.fadeOut(21));
       // fill(255, xAxis.fadeOut(11));
      } else {
        stroke(122,122,122);
       // fill(255);
      }
      
     
      //fadeOut();
      
      if (midline > height/2 - marginY && movingY){
          //text(showText(a).indexOf(".") < 0 ? showText(a) : showText(a).replaceAll("0*$", "").replaceAll("\\.$", ""),a-16,height/2 - (float) (midline + 6));
        line(a*sX,-(float) (midline + height/2),a*sX,(float) (height/2 - midline) - marginY); //this is the issue!
      } else {
      //text(showText(a).indexOf(".") < 0 ? showText(a) : showText(a).replaceAll("0*$", "").replaceAll("\\.$", ""),a-16,30); // x-axis
      line(a*sX,-height,a*sX,-2);
    }
    
  }
  
  if (xAxis.isFinished()) {
       // stop();
        xAxis.reset();
        startingX += xValue;
     } 
  
  for (float b = startingY; b < endingY; b += value){ //now we get a value problem, knew it was hiding somewhere!
    if (b == 0) continue;
   // println(b);
 /*  if (sY > 4*boundary){ //add new ticks!
     println("dsjidsijsdijsdjisd");
     value /= 2;
     boundary *= 4;
     sY = boundary;
   } */
   //stroke(250,22,120);
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
   
    essentialsY(b); //skip any 10xxx
    
  }
    
    if (Integer.parseInt(Double.toString(scalar).substring(0,1)) == 5){ //skip any 10x
    //fill(255,255,255,yAxis.fadeIn());
    stroke(122,122,122,yAxis.fadeIn());
    for (int c = floorAny(startingY,scalar); c < endingY; c += scalar){ //cant be exactly startingY now can it? this fills in the 500xxx!
       if (c == 0 || c % (2*scalar) == 0) continue;
       if (sX*(xCoord[max] - origin) > newWidth - textChange + startMovingX){
          line((float) (sX*(xCoord[max] - origin) - (newWidth - textChange + startMovingX) + approximateLineDistance(showText(c).length())),(-c)*sY,xV,(-c)*sY); // < ---- adjusts the 1280 - value!
      } else {
        line(-10,(-c)*sY,xV,(-c)*sY);
      }
    }
}
      
    //strokeWeight(4);
   // stroke(255,120,120);
    //strokeCap(ROUND);
}

String showText(double a){
  if (Math.round(a) >= 1000){
    String s = df.format(a/1000);
    return s.indexOf(".") < 0 ? s : s.replaceAll("0*$", "").replaceAll("\\.$", "") + "K";
  } 
  String s = Long.toString(Math.round(a));
  return s.indexOf(".") < 0 ? s : s.replaceAll("0*$", "").replaceAll("\\.$", "");
}

String showTextEpoch(double a){
  cal.setTime(new Timestamp((long) a));
  LocalDate date2 = Instant.ofEpochMilli((long) a * 1000).atZone(ZoneId.systemDefault()).toLocalDate();
  String strMonth2 = date2.getMonth().toString().substring(0,3);
  return "" + strMonth2.substring(0,1) + strMonth2.substring(1,3).toLowerCase() + " " + date2.getDayOfMonth() + ", " + date2.getYear();
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

int approximateLineDistance(int n){
  int r = 0;
  switch (n){
    case 1:
      r = -12;
      break;
    case 2:
      r = -6;
      break;
    case 3:
      r = 0;
      break;
    case 4:
      r = 10;
      break;
  } 
  
  return r;
}

void essentialsY(float n){
  //line(0,(-n)*sY,10000,(-n)*sY);
//  if (midline < 50) return;
  if (sX*(xCoord[max] - origin) > newWidth - textChange + startMovingX + 26){
     //println("testor123");
    //  text(showText(n),(float) (xCoord[max] - newWidth/2 - xPush),(-n+5)*sY);
      line((float) (sX*(xCoord[max] - origin) - (newWidth - textChange + startMovingX + 26) + approximateLineDistance(showText(n).length())),(-n)*sY,xV,(-n)*sY); // < ---- adjusts the 1280 - value! (no +200)
    } else {
   // text(showText(n),-60,(-n + 5)*sY); // y-axis
    line(-10,(-n)*sY,xV,(-n)*sY);
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
  //n = 2;
  for (int i = 0; i < n; i++){
    if (yCoords[max][i] < 0){
      n--;
      //print("gaymer");
      continue;
      }
    
    s += yCoords[max][i];
  }
  
  return sY*s/n;
}

void graphData(){ //max++ is intrinsic!
  autoScale(); //decor! 
  //background 0 is happening here.... no clue why :??
  //text("gamingFan120",500,-500);
  //initGraph();
   //Arrays.sort(yCoords[max]);
  for (int i = max-tailLength; i < max; i++){ //change 0 to max-constant (keeps program a little efficient!) //advances 1 every time it is redrawn 
    if (i < 0) continue;
    //print(i);s
    //sleep(1000);
    //println(yCoord.get(i)[0]);
    //println(max + " " + xCoord.get(i));
    strokeWeight(5);
    
    for (int c = 0; c < rowLength; c++){ //could put text into this one too, but that should go into info because they cannot overlap! 
    //or who knows might change my mind for efficiency reasons!
      if (yCoords[i][c] < 0) continue;
      stroke(hexValues[c]);
      line(sX* (float) (xCoord[i] - origin), -sY* (float) yCoords[i][c], sX *(float) (xCoord[i+1] - origin), -sY* (float) yCoords[i+1][c]);
      noStroke();
    } //should be fine............!
    
   // stroke(255,20,20);

    //line((float) xCoord[i], -sY* (float) yCoords[i][0], (float) xCoord[i+1], -sY* (float) yCoords[i+1][0]); //MESS WITH THIS !
   // stroke(20,255,50);
   // line((float) xCoord[i], -sY* (float) yCoords[i][1], (float) xCoord[i+1], -sY* (float) yCoords[i+1][1]);
   // stroke(20,50,255);
   // line((float) xCoord[i], -sY* (float) yCoords[i][2], (float) xCoord[i+1], -sY* (float) yCoords[i+1][2]);
    //filter(BLUR,0);
    }
   // text("gamingFan120",500,-500);
    for (int d = 0; d < yCoords[max].length; d++){
      if (yCoords[max][d] < 0) continue;
      fill(255);
      circle(sX* (float) (xCoord[max]-origin),(float) (-sY*yCoords[max][d]),12);
    }
    // text("gamingFan120",500,-500); DOESNT WORK!
    info(); //<--- only works info?!
    //text("gamingFan120",500,-500);
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
    midline = sumMid();
    //circle(sX*200,sY*  300,40); i^ and j^? (unit vectors)..? lol linear alg
}

void autoScale(){
   // line((float) xCoord[max] - width/2 - 15,-500,(float) xCoord[max] - width/2 - 15,500);
    maxVal = coordObj[rowLength - 1].yValue; // pushPop  is 220/sY + yChange
    if (maxVal * sY > invariant){ //very important! not changing the coordinate plane, just the values that objects take up in that coordinate plane!
     println("CALLED");
  //   sY = (float) ((pushPop*sY)/(maxVal - yChange));
     sY = (float) (invariant/maxVal); //proud!
     println("SY: " + sY + "BOUNDARY: " + boundary);
     // println("BOUNDARY: " + boundary + " SY: " + sY + " FREQ: " + (2));
    }
   // if ((midline + margin)/maxVal < relMax && moving){
     // println("ML : " + ((midline + 100)/maxVal) + " rM: " + relMax + "sY: " + sY + "xCoord : " + xCoord[max]);
  //    relMax = (midline + margin)/maxVal;
  //    instaChange(relMax,false);
 //  } //else println("relMax: " + relMax + " b: " + boundary + " dx " + dx);
   initGraph();
  // text("gamingFan120",500,-500);// does not work!
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
  textSize(36);
  //text("gamingFan120",500,-500); works!
  fill(0);
  noStroke();
  if (movingY){
  rect((float) -80,-65 + (float) (height/2 - midline),xV,70); //horizontalRect
  }
  
  if (sX*(xCoord[max] - origin) > newWidth - textChange + startMovingX){
    rect((float) (sX*(xCoord[max] - origin) - newWidth - startMovingX),-(float) (midline + height - marginY),100,(float) (midline + height)); //verticalRect
  }
  fill(255);

  for (float a = startingX; a < xV; a+=xValue){ //initialize lines and grid lines (x)
      if (a <= 0) {
        startingX = floorAny(sX*(xCoord[max] - origin) - width/2 - marginY,xValue); //maybe -origin, first startingX not needed :?
       // textSize(25); //oh this thing stops getting run lol
        //text(a,8,a-6);
        continue;
      }
     
     if (a < xCoord[max] - origin - (newWidth - textChange + startMovingX - 15)/sX){ //fix that later!
     //stroke(122,122,122,xAxis.getTransp());
     fill(255, xAxis.getTransp());
     } else {
        stroke(122,122,122);
        fill(255);
      }
      
    textAlign(CENTER);

    if (midline > height/2 - marginY && movingY){
            text(showTextEpoch(origin + a).indexOf(".") < 0 ? showTextEpoch(origin + a) : showTextEpoch(origin + a).replaceAll("0*$", "").replaceAll("\\.$", ""),a * sX -16,42 + yChange); //removes all .0s! REHAULT!
        } else {
        text(showTextEpoch(origin + a).indexOf(".") < 0 ? showTextEpoch(origin + a) : showTextEpoch(origin + a).replaceAll("0*$", "").replaceAll("\\.$", ""),a * sX -16,42); // x-axis
      }
    }
    
/*    if (xAxis.isFinished()) { //should work...!
        xAxis.reset();
        startingX += xValue;
      } */
     
  
  for (float b = startingY; b < endingY; b += value){
    if (b == 0 || b*sY < midline - height/2 + marginY + 4){//erase y-axis ticks before they hit the rect!
      continue;
    }
    
    //startingY = 0;
   // println(startingY);
    
   // if () 
    //println("XD: " + ((-b+5)*sY) + " ZAV: " + (height/2 - midline + 50));
      //continue;
    
    if (b % scalar != 0){ //weeding stage! (aka Oy) if 10xxx, just f00kin leave it alone! (ALREADY DONE!)
       // fadeOut(1)
        fill(255,255,255,yAxis.getTransp());
       // stroke(122,122,122,yAxis.getTransp());
       
      } 
      else {
          fill(255,255,255);
          stroke(122,122,122);
      }
      
     textAlign(CENTER,CENTER); //id fanman1
    if (sX*(xCoord[max] - origin) > newWidth - textChange + startMovingX + 20){ //120-94
    // println("testor123");
      text(showText(b),(float) (sX*(xCoord[max] - origin) - (newWidth - textChange + startMovingX + 20) + textMovementY),-b*sY);
      //-50 + something
    } else {
    text(showText(b),textMovementY,-b*sY); // y-axis
    }
    
   //   startingY = (int) (floorAny((midline - height/2 + 60)/sY,scalar)) > 0 ? (int) (floorAny((midline - height/2 + 60)/sY,scalar)) : 0; 
  }
  
  if (Integer.parseInt(Double.toString(scalar).substring(0,1)) == 5){ //skip 10x!
          fill(255,255,255,yAxis.fadeIn());
          //println(yAxis.fadeIn() * (255.0f/122));
          for (int c = floorAny(startingY,scalar); c < endingY; c += scalar){ //cant be exactly startingY now can it?
        //  println("C: " + c + " SCL: " + 2*scalar + " C % 2SCALAR == 0 " + (c%2*scalar==0)); //order of fuckin operations LOL
              if (c == 0 || c % (2*scalar) == 0) continue;
              if (sX*(xCoord[max] - origin) > newWidth - textChange + startMovingX){
              // println("testor123");
                text(showText(c),(float) (sX*(xCoord[max] - origin) - (newWidth - textChange + startMovingX) + textMovementY),-c*sY);
                //-50 + something
              } else {
                text(showText(c),textMovementY,-c*sY); // y-axis
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
      startingY = floorAny((midline - height/2 + marginY + 10)/sY,value) + (int) value; //Tick!
      
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
      frameRate(1);
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
 // surface.setVisible(false);
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
  initObjArr();
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
  saveFrame("frameReplace/line-######.png");
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

import java.util.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.*;
import java.sql.Timestamp;
import java.util.Collections;
//just imports it automatically lets goooooooo!

//works at 20k
//160,160,160 rgb for greyyyyyyyyy
LocalDate date;

PFont myFont;
PFont nameFont;
DecimalFormat df = new DecimalFormat("#.00");
DecimalFormat yearFormat = new DecimalFormat("0.##");
Calendar cal = Calendar.getInstance();
String[] days = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
String[] months = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec"};
List<Long> dateBuffer = new ArrayList<Long>();
boolean scalingDone = true;
boolean doNotMove = false;
boolean linesGone = false;
boolean runOnce = false;
boolean movingY = false;
boolean fading = false;
boolean debug = false;
boolean midlineScaling = false;
boolean isNull = false;

//PShader blur;
//FIX 100 multiple when 5'ving!
double debugMidline;
double midline;
double doublingFactor;
double xCoord[];
double yCoords[][];
double textCoords[];
String[] names;
Coord[] coordObj;

int grayscaleCoefficient = 190;
int fadeMoveX = 5;
int rowLength;
int reigning = 0;
int max = 0;
int newWidth = 1400; // i guess i gotta hard code this in :( 
int tailLength = 3000;
int margin = 320;
long startingY = 100;
int startMovingX = -55; //lovemyself! <-- def 150
int marginY = 90; ///70
int textMovementY = -33; // amount text is moved from canvas line x=0 <--- 26 comes from here i think...?
int monthCounter = 0;
int initialMonth = 9;
int prevNOA = 0;
int numOfArtists = 0;

float e = 1;
float xPush = 800;
float marking = 130; //how much the y-axis is moved at origin!!!!! default: 100
float slowPushY = 0;
float compensateX = 0;
float transpY = 255;
float transpX = 255;
float endingY;
float textY;
float xV;
float yChange;

double origin;
double relMax = 2;
double value = 100 * (1.0); //DO NOT TOUCH! nah //value is 200, sY is 1 if value is 500, sY has to be 0.4 but can be anything less???
double maxVal;
double minVal; 
double cut;
double invariant = 760;
float yCoefficient;
Map<Double,double[]> coords = new HashMap<Double,double[]>(); //04:17:02
//Map<Integer[],String> responses = new HashMap<Integer[],String>();

int[] hexValues = {#00FFFF,#ff0000,#00ff00,#966FD6,#ffff00,#ffc0cb,#008080,#d4560d};
int[][] countY;
PImage[] images;
PImage anon;
float sX = 1 / (19723.0); //default 20.0k, this SHOULD remain constant!
float xValue; //seconds! 
long startingX;
float sY = 2.3; //default : 2.3
float testorFan = sY*(1/2); //INTEGER DIVISION!
//float boundary = sY * (2.0/3); //this is a problem
float boundary = (sY * (2.0/3)); //comment out after!
float textChange = marking; //thank god for this! default: 100 (120) literally marking + 20???
double scalar = value*2; //lol
long epochAdv;
long epochBef;

Easing midlineEase;
Easing sYEase;
Scaling yAxis = new Scaling(255);
Scaling yAxisVertical = new Scaling(255);
Scaling xAxis = new Scaling(255);

/**
 * Initialize everything
 * Set
 */
void fetch(){

  // Custom values
  sY = 0.43;
  value = 500;
  scalar = 1000;
  boundary = 0.32;
  // Custom values
  
  yCoefficient = sY;
  String[] lines = loadStrings("datas.txt"); // Load all lines of datas.txt into a file.
  names = lines[0].split(" ");
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
  anon = loadImage("anon.png");
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
   
  date = Instant.ofEpochMilli((long) xCoord[max] * 1000).atZone(ZoneId.systemDefault()).toLocalDate(); // Create a unix time object! (.withDayOfMonth(1))
  
  println("STARTING DATE: " + date);
 // stop();
  for (int m = 0; m < initialMonth; m++){ // safe side
     // println(date.plusMonths(m*3));
      epochBef = date.plusMonths(m*3).atStartOfDay(ZoneId.systemDefault()).toEpochSecond();
      epochAdv = date.plusMonths((m+1)*3).atStartOfDay(ZoneId.systemDefault()).toEpochSecond();
      dateBuffer.add(epochAdv - epochBef);
   }
   
   startingX = (long) dateBuffer.get(0);
   
   for (int i = rowLength - 1; i >= 0; i--){
      double yCheck = coordObj[i].yValue;
      if (yCheck < 0){
        break;
      }
      numOfArtists++;
  }
  prevNOA = numOfArtists;
  midlineEase = new Easing(height/2 - marginY - 1,height/2 - marginY - 1);
  sYEase = new Easing(sY,sY);
  println("BEGINNNT: " + sYEase.incrementor);
}

//final float minY = min(IT );

/**
 * Creates canvas and two additional fonts. (Both at 150 to avoid downsampling)
 */
    void setup(){
  fetch();
  size(1920,1080,P2D);
  myFont = createFont("Lato",150,true);
  nameFont = createFont("Lato Bold",150,true);
  textFont(myFont);
  smooth(8);
  imageMode(CENTER);
}

String splitDate(long l){
  LocalDate beginning = Instant.ofEpochMilli((long) cut * 1000).atZone(ZoneId.systemDefault()).toLocalDate().plusMonths(1+reigning);

  if (date.compareTo(beginning) > 0){ //hmmm....? :?:?:?:?
    reigning++;
    //stop();
   // return String.format("%d months and %d days",reigning,l); 
  }
  
  println("REIGN: " + reigning);
  if (reigning > 0)
   return String.format("%d months and %d days",reigning,(date.atStartOfDay(ZoneId.systemDefault()).toEpochSecond() - beginning.plusMonths(-1).atStartOfDay(ZoneId.systemDefault()).toEpochSecond())/86400); 
    
 // else if (l > 365){
 //   return String.format("%d years and %d months",l/365,reigning-1);
//  } 

  else
   return String.format("%d days (~%s years)",l,yearFormat.format(l/365.0)); 

}

/**
 * Sets up the main text in the top half of the canvas.
 * Leader is in the top left along with the amount of days that they have been leader.
 * Date is in the top right, in Mon. Day, Year
 */
  void leaderboard(){
  int maxInd = rowLength - 1;
  Coord maxObj = coordObj[rowLength-1]; // Get maximum object
  if (maxObj.name != names[getIndexOfMax(yCoords[max+1])]){ // Check if the maxObj will be different in the next tick
    cut = xCoord[max]; // Reset cut to the point where the maximum object was 'overthrown'
    reigning = 0;
  }
    
    String daysPassed = splitDate(Math.round(xCoord[max] - cut)/86400);
    date = Instant.ofEpochMilli((long) xCoord[max] * 1000).atZone(ZoneId.systemDefault()).toLocalDate(); // Create a unix time object!
    
    //println(dateBuffer);
    //println("millis: " + Math.round(xCoord[max] - cut));


    fill(0,100);
    noStroke();
    beginShape();
      if (maxObj.yValue != -1){
      vertex(700 + daysPassed.length() * 24 - marking + compensateX, -height+41 + yChange);
      vertex(700 + daysPassed.length() * 24 - marking + compensateX, -height+261 + yChange);
      } else {
        vertex(690 - marking + daysPassed.length() * 24 + compensateX, -height+41 + yChange);
        vertex(690 - marking + daysPassed.length() * 24 + compensateX, -height+261 + yChange);
      }
      vertex(135 - marking + compensateX, -height+261 + yChange);
      vertex(135 - marking + compensateX, -height+41 + yChange);
    endShape();
    
    fill(255);
    stroke(255);
    textAlign(CENTER,CENTER);
    textSize(62);
    text("Leader: ",130+compensateX,-height + 150 + yChange);
    
    textAlign(LEFT); // Align all text to the left!
    textFont(nameFont); // Set textFont to a bolded Lato
    textSize(58);
    
    text("For " + daysPassed, 420+compensateX, -height + 227 + yChange); // Display difference of current date and date when #1 became #1
    
    textSize(60);
    
    if (maxObj.yValue != -1){
      text(""+maxObj.name.replace("_"," ") + " (" + Math.round(maxObj.yValue) + ")",420 + compensateX,-height + 160 + yChange);
      image(maxObj.img,320+compensateX,-height+165 + yChange,160,150); // Create an image with the maxObj's image attribute and place it at 260',130'
    }
    else {
      text("? (--)",420 + compensateX,-height + 160 + yChange);
      image(anon,320+compensateX,-height+165 + yChange,160,150);
    }

    textAlign(CENTER);

}
/**
 * Get the index of the maximum value
 * @param double[] Array
 * @return integer index of maximum value
 */

int getIndexOfMax(double[] arr){
  double largest = arr[0];
  int index = 0;
  for (int i = 1; i < arr.length; i++){
    if (arr[i] > largest){
      largest = arr[i];
      index = i;
    }
  }
  return index;
  
}


void info(){ //must multiply by reciprocal!
  //follow();
  
  leaderboard();
  fill(0,90);
  stroke(255); 
  strokeCap(ROUND);
  rectMode(CORNER);
  textSize(36);
        
  noStroke();
  beginShape();
    vertex(width - 520 - marking + compensateX, -height+41 + yChange);
    vertex(width - 520 - marking + compensateX, -height+271 + yChange);
    vertex(width - marking + compensateX, -height+271 + yChange);
    vertex(width - marking + compensateX, -height+41 + yChange);
  endShape();
  stroke(255);
    //rect(width - 350 - marking, -height + 50, 350, height-50)

        
    fill(255);
    textSize(76);
    text("        Current Date:",width-330-marking + compensateX,-height + 168 + yChange);
  //  funAilun(width-170-marking + compensateX,-480);
    textSize(72);
    String strMonth = date.getMonth().toString().substring(0,3);
    text("" + strMonth.substring(0,1) + strMonth.substring(1,3).toLowerCase() + " " + date.getDayOfMonth() + ", " + date.getYear(),width-271-marking + compensateX,-height + 249 + yChange);
  
  //fill(255);
 // text(sX*xCoord[max]+","+ (yCoords[max][0]), (float) (width/2 + 70 + xCoord[max] - xPush),(float) -(midline + 410)); //index yCoords because it is a list of values, adding 1 should make such an insignifcant difference that it is not needed
  //(float) (double) xCoord.get(i), (float) (double) xCoord.get(i+1), (float) yCoord.get(i)[0],(float) yCoord.get(i+1)[0]
  textFont(nameFont);
  textSize(52); // 52 change!
  
  
  //textCoords[rowLength-1] = coordObj[rowLength - 1].yValue + 1/sY; //aka maximum of the list!
  for (int c = 0; c < rowLength; c++){ //first init..:?
    if (coordObj[c].yValue < 0) continue;
    else if (coordObj[c].yValue < 10/sY && c == rowLength - 1) textCoords[c] = 10/sY;
    textCoords[c] = coordObj[c].yValue - 5/sY; //initialize TC properly!
  }

  for (int c = rowLength - 2; c >= 0; c--){
   int k = 3;
   if (coordObj[c].yValue < 0) continue;
   
   if (textCoords[c+1] - textCoords[c] < 46/sY || (c != rowLength - 2 && textCoords[c+1] - k/sY*countY[c+1][c+2] - textCoords[c] < 46/sY)){ ///oh shit L O L o_O Kevin IS NO LONGER AFFECTED BY THIS!!!!!!!!!!!!!!!
     if (c == rowLength - 2)
       textCoords[c] = textCoords[c+1] - 45/sY; // ok, this is linked to the textSize, not the -c/sY! they are not inversly related
     else
       textCoords[c] = textCoords[c+1] - 45/sY - k/sY*countY[c+1][c+2]; // k/sY*countY[c+1][c+2] if only there was a way to keep tc[c+1] - 33/sY frozen for long enough so that the transition has finished...
     
     if (coordObj[c].futureY > coordObj[c+1].futureY){
       countY[c][c+1]++;
       double changeAmt = k/sY * countY[c][c+1];
       textCoords[c] += changeAmt;
       textCoords[c+1] -= changeAmt;
     } else {
     //  balance = 0;
    // println("gamers");
       if (countY[c][c+1] > 9){
         countY[c][c+1] = 0;
       }
     }
   }
  // textCoords[c] = coordObj[c].yValue + 1/sY; //works!
 //  textCoords[c] = yCoords[max][c] + 1/sY; //doesn't work!

      
  }
   
 for (int c = 0; c < rowLength; c++){ //doesnt work because richard comes before andy! a change from andy does not affect richard!
   if (coordObj[c].getYCoord() < 0) continue;
      fill(coordObj[c].hexCode,255);
      //check();
    //  int k = 3;
      textAlign(LEFT);
     // int m = getClosestPair(c); // <---THIS! IS PROBLEMgets closest neighbor thats ABOVE IT! (if -1, yer top dawggg)


      textY = (float) textCoords[c];
  
      //}       
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
   
}


/**
  * 
  *
  *
*/
float sumMid(){
  

  
  float s = 0;
  int n = 0;
  //n = 2;
  for (int i = rowLength - 1; i >= 0; i--){
    double yCheck = coordObj[i].yValue;
    if (yCheck < 0){
      break;
    }
    s += yCheck;
    n++;
  } 
   
  numOfArtists = n;
  
  float midlineToBe = sY*s/n;
  
  if (Double.isNaN(midlineToBe)){
    midlineToBe = 0;
  }
  
  if (debug)
    return (float) debugMidline;
   
  midlineScaler(midlineToBe);
   
  return midlineEase.incrementor;

}

void midlineScaler(float ml){
  // if prevN == ? and n == !, then ease!
  //println("TF: " + midlineEase.incrementor + " status: " + midlineScaling);
  if (numOfArtists != prevNOA && ml > height/2 - marginY){
      midlineEase.setChange(ml);
      midlineScaling = true;
  }
  
  if (midlineScaling){
    midlineEase.incEase(1.03);
    midlineEase.doStuff();
    
    if (midlineEase.isEqual()){
      midlineScaling = false;  
      prevNOA = numOfArtists;
      
    }
  }  
   else {
     //println("JUMP");
     if (ml > height/2 - marginY)
       midlineEase.incrementor = ml;   

   }

}

void follow(){
//  println("m: " + midline);
  //pushPop = 220/sY;

  if (midlineEase.incrementor < height/2 - marginY){
    slowPushY = height - marginY;
    movingY = false;
    yChange = 0;
    
  }
  else {
   // println(midline);
    slowPushY = (float) (height/2 + midlineEase.incrementor);
    movingY = true;
    yChange = -(float) (midlineEase.incrementor - height/2 + marginY);
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
  int mC = 0;
  xValue = dateBuffer.get(mC);
  for (float a = startingX; a < xV; a += xValue){ //initialize lines and grid lines (x) 
      mC++;
      xValue = dateBuffer.get(mC);
     // println("XV: " + xValue + " A: " + a);
      if (a <= 0) {
       // startingX = floorAny(sX*(xCoord[max] - origin) - newWidth + marking,xValue); //default: xValue keeps reverting to 750 (maybe -origin)
        textSize(25);
        //text(a,8,a-6);
        continue;
      }
      
      if (a < xCoord[max] - origin - (newWidth - textChange + startMovingX - fadeMoveX)/sX){ //id: fading default +15 //26 from 120-94 :(
        //begin fading!
        stroke(122,122,122, xAxis.fadeOut(21));
       // fill(255, xAxis.fadeOut(11));
      } else {
        stroke(122,122,122);
       // fill(255);
      }    
    
    line(a*sX,yChange-height,a*sX,movingY ? yChange : -2);
  }
  
  if (xAxis.isFinished()) {
        monthCounter += 3;
        dateBuffer.remove(0);
        epochBef = date.plusMonths(monthCounter + initialMonth*3).atStartOfDay(ZoneId.systemDefault()).toEpochSecond();
        epochAdv = date.plusMonths(monthCounter + initialMonth*3).atStartOfDay(ZoneId.systemDefault()).toEpochSecond();
        dateBuffer.add(epochAdv - epochBef);
        xAxis.reset();
        startingX += xValue;
     } 
  
  for (float b = startingY; b < endingY; b += value){ //now we get a value problem, knew it was hiding somewhere!
    if (b == 0) continue;
   //stroke(250,22,120);
   strokeWeight(3); //yAxis strokes
//  line(-700,-(float) midline,700,-(float) midline); midlineTestLine //hmmm maybe this isnt needed!
   stroke(122,122,122);
   
  //  println(midline/sY + height/(2*sY));
    if (sY < boundary){ // shrinkinGraph code!
      
      if (b % scalar != 0){ 
        
        //  fill(255,255,255,yAxis.fadeOut(1.6));
          stroke(122,122,122,yAxis.fadeOut(3.6));
       
      } 
      else {
        //  fill(255,255,255);
          stroke(122,122,122);
      }
    }
   
    essentialsY(b); //skip any 10xxx
    
  }
    
    if (Integer.parseInt(Double.toString(scalar).substring(0,1)) == 5){ //skip any 10x
    //fill(255,255,255,yAxis.fadeIn());
    stroke(122,122,122,yAxis.fadeIn());
    for (int c = floorAny(startingY,scalar); c < endingY; c += scalar){ //cant be exactly startingY now can it? this fills in the 500xxx!
       if (c == 0 || c % (2*scalar) == 0) continue;
       if (sX*(xCoord[max] - origin) > newWidth - textChange + startMovingX + 26){             //
          line((float) (sX*(xCoord[max] - origin) - (newWidth - textChange + startMovingX + 26 + approximateLineDistance(showText(c).length()))),(-c)*sY,xV,(-c)*sY); // < ---- adjusts the 1280 - value! + approximateLineDistance(showText(c).length())
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
  //println("sY: " + sY + " v: " + v);
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
    case 2:
      r = 10;
      break;
    case 3:
      r = 20;
      break;
    case 4:
      r = 30;
      break;
  } 
  
  return r;
}

void essentialsY(float n){

  if (sX*(xCoord[max] - origin) > newWidth - textChange + startMovingX + 26){ 
                                                                                           //  + approximateLineDistance(showText(n).length())
      line((float) (sX*(xCoord[max] - origin) - (newWidth - textChange + startMovingX + 26) + approximateLineDistance(showText(n).length())),(-n)*sY,xV,(-n)*sY); // < ---- adjusts the 1280 - value! (no +200)
    } else {

    line(-17,(-n)*sY,xV,(-n)*sY);
    }
  
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

void graphData(){ //max++ is intrinsic!
  isNull = Math.abs(coordObj[rowLength - 1].yValue + 1.0) < 0.001;
  //println(isNull);
      midline = sumMid();
  autoScale(); //decor!
  //background 0 is happening here.... no clue why :??
  for (int i = max-tailLength; i < max; i++){ //change 0 to max-constant (keeps program a little efficient!) //advances 1 every time it is redrawn 
    if (i < 0) continue;

    strokeWeight(10);
    
    for (int c = 0; c < rowLength; c++){ //could put text into this one too, but that should go into info because they cannot overlap! 
    //or who knows might change my mind for efficiency reasons!
      if (yCoords[i][c] < 0) continue;
      stroke(hexValues[c]);
      line(sX* (float) (xCoord[i] - origin), -sY* (float) yCoords[i][c], sX *(float) (xCoord[i+1] - origin), -sY* (float) yCoords[i+1][c]);
      noStroke();
    } //should be fine............!
    
    }
   // text("gamingFan120",500,-500);
    for (int d = 0; d < yCoords[max].length; d++){
      if (yCoords[max][d] < 0) continue;
      fill(255);
      circle(sX* (float) (xCoord[max]-origin),(float) (-sY*yCoords[max][d]),25);
    }
    // text("gamingFan120",500,-500); DOESNT WORK!
  //  if (!isNull)
    info(); //<--- Fix when no yCoords...

    blackBox();

   // println("MIDLINE: " + midline);
   println("CURRENT SY: " + sY + " CURRENT BG: " + boundary);
   // if (Double.isNaN(midline))
     // midline = 0; // this is probably not the best solution...? <-- some how ease this!
    

    //circle(sX*200,sY*  300,40); i^ and j^? (unit vectors)..? lol linear alg
}

void sYScaling(float v){

   // if prevN == ? and n == !, then ease!
  println("TF: " + midlineEase.incrementor + " status: " + midlineScaling);
  sYEase.setChange(v);
  
  if (sYEase.isEqual()){
    sYEase.incrementor = v;
    return;
  }

  sYEase.incEase(1.03);
  sYEase.doStuff();
  

}

void autoScale(){
    
    if (max > 1 && getMaxValue(yCoords[max-1]) > getMaxValue(yCoords[max]) && sY / 1.1 < boundary){
        // use the Easing sY object!
    }
    
    
    maxVal = coordObj[rowLength - 1].yValue; // pushPop  is 220/sY + yChange
    sYScaling(yCoefficient);

    if (maxVal * sY > invariant){ //very important! not changing the coordinate plane, just the values that objects take up in that coordinate plane!
     yCoefficient = (float) (invariant/maxVal);
     sY = sYEase.incrementor; // <--- This is causing a fast movement, delay for now!

    }

   initGraph();
     
     
    if (sY*maxVal > midline + margin){
      scalingDone = false;
      //text((float) (1/sY * midline), -600, -(float) (midline + 340));
    }
    
}

void blackBox(){ //WORKS, DO MORE TESTING WITH IT LATER!!!!
  textFont(nameFont); //
  //text("gamingFan120",500,-500); works!
  fill(0);
  noStroke();
  if (movingY){
  rect((float) -80,-85 + (float) (height/2 - midline),xV,90); //horizontalRect
  }
  
  if (sX*(xCoord[max] - origin) > newWidth - textChange + startMovingX){
    rect((float) (sX*(xCoord[max] - origin) - newWidth - startMovingX),-(float) (midline + height - marginY),115,(float) (midline + height)); //verticalRect
  }
  fill(255);
  
  int mC = 0;
  xValue = dateBuffer.get(mC);
  
  textSize(47);
  for (float a = startingX; a < xV; a += xValue){ //initialize lines and grid lines (x)
      mC++;
      xValue = dateBuffer.get(mC);
      if (a <= 0) {
        startingX = floorAny(sX*(xCoord[max] - origin) - width/2 - marginY,xValue); //maybe -origin, first startingX not needed :?
       // textSize(25); //oh this thing stops getting run lol
        //text(a,8,a-6);
        continue;
      }
     
     if (a < xCoord[max] - origin - (newWidth - textChange + startMovingX - fadeMoveX)/sX){ //fix that later! id: fading
     //stroke(122,122,122,xAxis.getTransp());
     fill(grayscaleCoefficient, xAxis.getTransp());
     } else {
        fill(grayscaleCoefficient);
      }
      
    textAlign(CENTER);

    if (midline > height/2 - marginY && movingY){
            text(showTextEpoch(origin + a).indexOf(".") < 0 ? showTextEpoch(origin + a) : showTextEpoch(origin + a).replaceAll("0*$", "").replaceAll("\\.$", ""),a * sX - 6,57 + yChange); //removes all .0s! REHAULT!
        } else {
        text(showTextEpoch(origin + a).indexOf(".") < 0 ? showTextEpoch(origin + a) : showTextEpoch(origin + a).replaceAll("0*$", "").replaceAll("\\.$", ""),a * sX - 6,57); // x-axis
      }
    }
    
  textSize(48);
  for (float b = startingY; b < endingY + 6/sY; b += value){ // its only the text LOL 
    if (b == 0 || b*sY < midline - height/2 + marginY + 2){//erase y-axis ticks before they hit the rect! ID: disappear
      continue;
    }
    
    
    if (b % scalar != 0){ //weeding stage! (aka Oy) if 10xxx, just f00kin leave it alone! (ALREADY DONE!)

        fill(grayscaleCoefficient,yAxis.getTransp());

      } 
      else {
          fill(grayscaleCoefficient,255);
      }
      
     textAlign(RIGHT,CENTER); //id fanman1
    if (sX*(xCoord[max] - origin) > newWidth - textChange + startMovingX){ //120-94

      text(showText(b),(float) (sX*(xCoord[max] - origin) - (newWidth - textChange + startMovingX) + textMovementY),-b*sY - 2);

    } else {
      
    text(showText(b),textMovementY,-b*sY - 2); // y-axis
    
    }

  }
  
  if (Integer.parseInt(Double.toString(scalar).substring(0,1)) == 5){ //skip 10x!
          fill(grayscaleCoefficient,yAxis.fadeIn());
          //println(yAxis.fadeIn() * (255.0f/122));
          for (int c = floorAny(startingY,scalar); c < endingY; c += scalar){ //cant be exactly startingY now can it?
        //  println("C: " + c + " SCL: " + 2*scalar + " C % 2SCALAR == 0 " + (c%2*scalar==0)); //order of fuckin operations LOL
              if (c == 0 || c % (2*scalar) == 0) continue;
              if (sX*(xCoord[max] - origin) > newWidth - textChange + startMovingX){
              // println("testor123");
                text(showText(c),(float) (sX*(xCoord[max] - origin) - (newWidth - textChange + startMovingX) + textMovementY),-c*sY - 2);
                //-50 + something
              } else {
                text(showText(c),textMovementY,-c*sY - 2); // y-axis
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
     debug = true;
     break;
    case 'x':
      frameRate(1);
      break;
    case 'v':
      linesGone = !linesGone;
      break;
    case 'g':
      debug = true;
      debugMidline += 100;
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
  
 // println("XSIZE " + xCoord.size());
  scale(1*e);
  initObjArr();
  follow();
  graphData();
  //info();
  max++; 

  //saveFrame("testAilun/line-######.png");
}

void increaseScale(){
  e += 0.01;
}

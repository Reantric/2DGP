import processing.core.*;
import java.util.*;
import java.text.DecimalFormat;
DecimalFormat df = new DecimalFormat("###.#");

public class CartesianPlane extends MObject implements Plane { // Work on mouseDrag after!
    float xValue;
    float yValue;
    float transparency = 255;
    float sX;
    float sY;
    float startingX;
    float startingY;
    float rescaleX;
    float rescaleY;
    float scaleFactor;
    float max = 0; //counter
    float currentColor = 0;
    boolean restrictDomain = false;
    float restrictedDomainX1;
    float restrictedDomainX2;
    List<Double> randArr = new ArrayList<Double>();
    float finalValue;
    PGraphics canvas;
    float aspectRatio;
    int delVal;
    
    /* Object initializations */  // Create color object soon for animateVector();
    List<PVector> points = new ArrayList<PVector>();
    Scaling scaler = new Scaling(0);
    Scaling fadeGraph = new Scaling();
    Easing slowRotate = new Easing(0);
    Easing animVector = new Easing(0); // change later
    Easing originTriangle = new Easing(0,12);
   // Arrow traceGraphF = new Arrow(12,true,xValue);
   // Arrow traceGraphG = new Arrow(12,true,xValue);
    /* Object initializations */
    
    
    /**
     *
     * @param xSpace Distance between x ticks
     * @param ySpace Distance between y ticks
     */
    public CartesianPlane(float xSpace, float ySpace,PGraphics p){
        super(p,0,0,p.width,p.height,0);
        xValue = xSpace;
        yValue = ySpace;
        canvas = p;
        rescaleX = (float) canvas.width/WIDTH;
        rescaleY = (float) canvas.height/HEIGHT;
        sX = 200/xValue * rescaleX;
        sY = 200/yValue * rescaleY;
        scaleFactor = 6/5.0 * xValue/100.0;
        scaleFactor = 0.06; // debug
        startingX = (float) Useful.floorAny(-canvas.width/(2*sX),xValue); // <---- Issues here when resizing canvas 
        startingY = (float) Useful.floorAny(-canvas.height/(2*sY),yValue); // <---- Issues here when resizing canvas 
        max = startingX - xValue/5; // should start at 25
        aspectRatio = (WIDTH/1080)/(rescaleX/rescaleY);
        delVal = 159;
        println("please: " + WIDTH + " diff: " + width);

    }
    
    /**
     *
     * Creates a 2D Cartesian Plane with an x axis and a y axis
     */
    public void generatePlane(){
       currentColor = Useful.getColor(max,startingX,-startingX);
       canvas.beginDraw();
       canvas.background(0);
       canvas.textFont(myFont);
       canvas.textSize(38);
       canvas.textAlign(CENTER,CENTER);
       canvas.colorMode(HSB);
       canvas.translate(canvas.width/2,canvas.height/2);
       canvas.stroke(150,200,255);
       canvas.strokeWeight(4);
       
       
     //  pushMatrix();
       canvas.rotate(slowRotate.incrementor); //-PI/2
                
       for (float x = startingX; x < -startingX; x += xValue/2){
          if (x == 0) continue;
          
          if (x % xValue == 0)
            canvas.strokeWeight(4);
          else
            canvas.strokeWeight(1.5);
            
          canvas.line(sX*x,sY*startingY,sX*x,sY*-startingY);
  
        }
        
        
        for (float y = startingY; y < -startingY; y += yValue/2){
          if (y == 0) continue;
          
          if (y % yValue == 0)
            canvas.strokeWeight(4);
          else
            canvas.strokeWeight(1.5);
            
          canvas.line(-sX*startingX,sY*y,sX*startingX,sY*y);
         
        }
        
        canvas.stroke(0,0,255);
        canvas.strokeWeight(4);
        
        canvas.line(-sX*startingX,0,sX*startingX,0);
        canvas.line(0,-sY*startingY,0,sY*startingY);
        
     //   popMatrix();

        
    }
    
    /**
    * Label all axes
    */
    public void labelAxes(){
      canvas.textSize(42);
      canvas.textAlign(CENTER);
      canvas.rectMode(CENTER);
      for (float x = startingX; x < -startingX; x += xValue){ //-width/(2*sX) - xValue/5 + xValue, starting 0,0 at width/2, height/2

            if (x == 0) continue;
            
            String tX = df.format(x);
            canvas.noStroke();
            canvas.fill(0,0,0,125);
            canvas.rect(sX*x,30,60 + (tX.length()-3)*10,56);
            canvas.fill(255);
            if (x > 0)
              canvas.text(tX,sX*x,44);
            else
              canvas.text(tX,sX*x-8,44);
          }
      
      canvas.textAlign(RIGHT);
      for (float y = startingY; y < -startingY; y += yValue){
          if (y == 0) continue;
          canvas.text(df.format(-y),-12,sY*y-12);
        }

    }
    
    public void display(Object... obj){
      labelAxes();
      canvas.endDraw();
      //PImage frame = canvas.get(); Much more laggy!
      //pushMatrix();
      //translate(canvas.width/2,canvas.height/2);
      stroke(currentColor,255,255);
      strokeWeight(7);
      noFill();
      rect(pos.x,pos.y,canvas.width,canvas.height);
      image(canvas,pos.x,pos.y);
     // popMatrix();
    }
    

    /**
     * Graph any function
     */
    public void graph(){
      float sMax, endG;
      if (restrictDomain){
        sMax = restrictedDomainX1;
        endG = restrictedDomainX2;
      } else {
        sMax = startingX;
        endG = max;
      }
      
   //   loadRandArr();

    //  traceGraphF.vector.set(max,f(max+scaleFactor) * aspectRatio); // just the aspect ratios!
    //  traceGraphG.vector.set(max,g(max+scaleFactor) * aspectRatio);

      canvas.strokeWeight(5);
      canvas.strokeCap(ROUND);
      for (float i = startingX; i < max; i+=scaleFactor){
        if (i < sMax || i > endG){
           canvas.stroke(125,255,255,fadeGraph.fadeOut(0.01));
        } else
           canvas.stroke(Useful.getColor(i,startingX,-startingX),255,255);
        
        /* Optimize graph, only use if no autoscale! */

        /*
        for (int t = 0; t < 5 && f(i) > -startingY; t++){
          float jumpDistance = 5*scaleFactor;
          if (f(i+jumpDistance) < -startingY){
            finalValue = jumpDistance;
          }
        }
        max = finalValue - 5*scaleFactor;
        */
        
        /* Optimize graph, only use if no autoscale! */
        
        canvas.line(sX*i,-sY*f(i),sX*(i+scaleFactor),-sY*(f(i+scaleFactor)));
        canvas.line(sX*i,-sY*g(i),sX*(i+scaleFactor),-sY*(g(i+scaleFactor)));
        

      }
      
      if (max < -startingX) max+=scaleFactor;
      

      
     if (max > -2.88 && max < 2.88) max -= 0.058;
    //  println("x: " + max + " y: " + f(max));
   //   drawVector(traceGraphF);
    //  drawVector(traceGraphG);
    }

      
    public long factorial(int number) {
        long result = 1;

        for (int factor = 2; factor <= number; factor++) {
            result *= factor;
        }

        return result;
    }
    

    
    /**
     *
     * @param x Input to the function (x-coord)
     * @return Output to the function (y-coord)
     */
    public float f(float x){
      
      return 0.2*x;
      //(float) (double) randArr.get((int) x + 25);
    }
    
   public float g(float x){
      return x < 0 ? -4*sin(x): (float) -log(x);
   }

    public void loadRandArr(){
      randArr.add(10*Math.random() - 5);
    }
    /**
     *
     * @param x1 Left side of domain restriction
     * @param x2 Rigt side of domain restriction
     * Restrict the domain
     */
    public void restrictDomain(float x1, float x2){
      restrictedDomainX1 = x1;
      restrictedDomainX2 = x2;
      restrictDomain = true;
    }

    /**
     *
     * @param theta Angle to be inputted
     * Rotates the plane by theta degrees
     */
    public void rotatePlane(float theta){ // To be changed with Easing class!
      
      slowRotate.setChange(theta);
      slowRotate.incEase(1.045);
      slowRotate.doStuff();
      
      /* if (slowRotate.easing < 0.05 && !slowRotate.isEqual())
          slowRotate.incEase(1.045);
        
        
      if (!slowRotate.isEqual())
          slowRotate.incValue();
       

        if (slowRotate.isEqual())
          slowRotate.reset(); */
        

    }
   
    
    /**
    * Get derivative given two values
    */
    public void derivative(float y1, float y2, float distX){
      canvas.stroke(255);
      canvas.line(sX*(max+2),sY*y1,sX*(max-2),sY*y2);
    }
    
    public void autoscale(){
      // To be implemented
    }
    
    /**
    * @param x x-coordinate of point
    * @param y y-coordinate of point
    * Creates a visible point at that location
    */
    public void createPoint(float x, float y){
      
      points.add(new PVector(x,y));

      canvas.stroke(255,scaler.fadeIn(9));
      canvas.fill(255,scaler.getTransp());
      canvas.circle(x,y,20);
  }
  
  /**
  * @param v Vector to be drawn
  * Draws vector in Cartesian Space
  */
  public void drawVector(Arrow arrow){ //no need to graph and that stuff, just show vector!
    PVector v = arrow.vector; // aliases
    arrow.drawArc(canvas);
    canvas.colorMode(HSB); 
    float triangleSize;
    canvas.pushMatrix();

        
      arrow.doStuff(1.045);

     
     triangleSize = arrow.triangleSize;
     canvas.strokeWeight(arrow.triangleSize * 10.0/12);


      float rotationAngle = v.heading();
      //should draw Ellipse but is drawing circle (FIX FOR OTHER RES OF CANVAS)
      float magnitude = arrow.getMag(sX,aspectRatio); // max < 0 ? sX*v.mag() - 16 : sX*v.mag(); //arrow.vectorMag; // 6 works...?! apply ease to this v.mag() - 6

      canvas.stroke(currentColor,255,255);
      canvas.strokeCap(ROUND);
      

      
      /* text */
      canvas.fill(Useful.getColor(arrow.coordsSize,0,delVal),255,255);
      
      if (TAU + rotationAngle > 3*PI/2 && rotationAngle < 0)
        Useful.rotatedText(df.format(degrees(rotationAngle > 0 ? rotationAngle : TAU + rotationAngle))+"°",canvas,sX*v.x/4,-sY*v.y/4,PI-rotationAngle);
      else
        Useful.rotatedText(df.format(degrees(rotationAngle > 0 ? rotationAngle : TAU + rotationAngle))+"°",canvas,sX*v.x/4.75,-sY*v.y/4.75,PI-rotationAngle);
        
      canvas.textSize(80);
      canvas.fill(255,255,255);
      Useful.rotatedText(Useful.propFormat(v.mag()),canvas,sX*v.x/2 ,-sY*v.y/2,PI-rotationAngle);
      /* text */
    
      canvas.rotate(-rotationAngle);

      canvas.line(0,0,magnitude,0);
      
      canvas.beginShape(TRIANGLES);
        canvas.vertex(magnitude - triangleSize*1.5 + 8,-triangleSize);
        canvas.vertex(magnitude + 8, 0);
        canvas.vertex(magnitude - triangleSize*1.5 + 8,triangleSize);
      canvas.endShape();
     // canvas.triangle(magnitude-triangleSize*1.6,triangleSize,magnitude-triangleSize*1.6,-triangleSize,magnitude,0);
      
    canvas.popMatrix();
    
    arrow.addPoint(sX*v.x,-sY*v.y);
    arrow.graph(canvas,delVal); //delVAL
    /* overlaying text */
     canvas.textSize(42);
     canvas.fill(128,255,255);
     if (PI-rotationAngle < 3*PI/2 && PI-rotationAngle > PI/2)
       canvas.textAlign(LEFT,CENTER);
     else
       canvas.textAlign(RIGHT,CENTER);
     canvas.text(String.format("[cos(%s),sin(%s)]",df.format(v.x),df.format(v.y)),1.09*sX*v.x,1.09*-sY*v.y);
    /* overlaying text */
    
    /* cherry on top */
    canvas.noStroke();
    canvas.fill(Useful.getColor(arrow.coordsSize,0,delVal),255,255);
    canvas.circle(sX*v.x,-sY*v.y,8);
    
  }
  
  /**
  * @param initial PVector's initial position (Starting)
  * @param output PVector's ending position (Ending)
  * Animates using an ease function the PVector moving to its output
  */
  public void moveVector(PVector initial, PVector output){ // check implementAV.png
    // To be implemented
  }
  
  public void run(PGraphics p){
    // To be implemented
  }
    
}

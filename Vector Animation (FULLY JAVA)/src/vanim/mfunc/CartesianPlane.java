package vanim.mfunc;
import static vanim.planar.*;
import vanim.misc.*;
import vanim.planar;
import vanim.shapes.*;
import processing.core.*;

import java.util.*;


import java.lang.*;

import java.util.ArrayList;


public class CartesianPlane extends MObject implements Plane { // Work on mouseDrag after!
    public float xValue;
    public float yValue;
    public float transparency = 255;
    public float sX = 1;
    public float sY = 1;
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
    public int delVal;

    /* Object initializations */  // Create color object soon for animateVector();
    public MObject xAxis,yAxis;
    public MObject[] xLines, yLines;
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
    public CartesianPlane(PApplet p, PGraphics c, float xSpace, float ySpace){
        super(p,c,0,0,p.width,p.height,0);
        xValue = xSpace;
        yValue = ySpace;
        canvas = c;
        rescaleX = (float) canvas.width/WIDTH;
        rescaleY = (float) canvas.height/HEIGHT;
        sX = 200/xValue * rescaleX;
        sY = 200/yValue * rescaleY;
        scaleFactor = 6/5.0f * xValue/100.0f;
        scaleFactor = 0.06f; // debug
        startingX = (float) Useful.floorAny(-canvas.width/(2*sX),xValue); // <---- Issues here when resizing canvas
        startingY = (float) Useful.floorAny(-canvas.height/(2*sY),yValue); // <---- Issues here when resizing canvas
        max = startingX - xValue/5; // should start at 25
        aspectRatio = (WIDTH/1080.0f)/(rescaleX/rescaleY);
        delVal = 159;
        //canvas.line(-sX*startingX,0,sX*startingX,0);
        xAxis = new DoubleLine(canvas,sX*startingX,0,-sX*startingX,0);
        yAxis = new DoubleLine(canvas,0,sY*startingY,0,-sY*startingY);
        frameCountInit = processing.frameCount;
        frameCountBuffer = 15;
        /* MObject[] inits */
        xLines = new MObject[(int) (-4*startingX/xValue)]; // skip over 0
        yLines = new MObject[(int) (-4*startingY/yValue)]; // skip over 0

        // Make for loop more efficient
        for (int i = 0; i < xLines.length; i++){
            if (i == xLines.length/2) continue;

            xLines[i] = new DoubleLine(canvas,sX*(startingX + xValue*i/2),sY*startingY,sX*(startingX + xValue*i/2),sY*-startingY,(startingX + xValue*i/2)%xValue == 0 ? 4 : 1.5f);
        }

        for (int j = 0; j < yLines.length; j++){
            if (j == yLines.length/2) continue;

            yLines[j] = new DoubleLine(canvas,sX*startingX,sY*(startingY + yValue*j/2),-sX*startingX,sY*(startingY + yValue*j/2),(startingY + yValue*j/2)%yValue == 0 ? 4 : 1.5f);
        }
    }

    /**
     *
     * Creates a 2D Cartesian Plane with an x axis and a y axis
     * @return
     */
    public boolean generatePlane(){
        boolean complete = true;
        currentColor = Useful.getColor(max,startingX,-startingX);
        canvas.beginDraw();
        canvas.background(0);
        canvas.textFont(myFont);
        canvas.textSize(38);
        canvas.textAlign(CENTER,CENTER);
        canvas.colorMode(HSB);
        canvas.translate(canvas.width/2.0f,canvas.height/2.0f);
        canvas.stroke(150,200,255);
        canvas.strokeWeight(4);


        //  pushMatrix();
        canvas.rotate(slowRotate.incrementor); //-processing.PI/2
       // incrementor = 0;

        for (int j = 0; j < yLines.length; j++){
            if (j == yLines.length/2) continue;
            if (!yLines[j].display())
                complete = false;
        }
        //Make both for loops more efficient, both here and in the constructor!
        if (!xAxis.display()) complete = false;
        if (processing.frameCount < frameCountInit + frameCountBuffer) return false;

        for (int i = 0; i < xLines.length; i++){
            if (i == xLines.length/2) continue;
            if (!xLines[i].display())
                complete = false;
        }
       /* for (float x = startingX; x < -startingX; x += xValue/2){
            if (x == 0) continue;


            if (x % xValue == 0)
                canvas.strokeWeight(4);
            else
                canvas.strokeWeight(1.5f);

            canvas.line(sX*x,sY*startingY,sX*x,sY*-startingY); // |

            //incrementor++;
        } */
     //   println("INC: " + incrementor + " ART: " + xLines.length); INCREMENTOR is 1 less than xLines.length, expected!

     /*   for (float y = startingY; y < -startingY; y += yValue/2){
            if (y == 0) continue;

            if (y % yValue == 0)
                canvas.strokeWeight(4);
            else
                canvas.strokeWeight(1.5f);

            canvas.line(-sX*startingX,sY*y,sX*startingX,sY*y); // --

        } */

        canvas.stroke(0,0,255);
        canvas.strokeWeight(4);

        //>= optimalDelVal


        return complete & yAxis.display();
       // return xAxisR.display() & yAxisU.display() & xAxisL.display() & yAxisD.display();
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

    public boolean display(Object... obj){
        labelAxes();
        canvas.endDraw();
        //processing.PImage frame = canvas.get(); Much more laggy!
        //pushMatrix();
        //translate(canvas.width/2,canvas.height/2);
        processing.stroke(currentColor,255,255);
        processing.stroke(233);
        processing.strokeWeight(7);
        processing.noFill();
        processing.rect(pos.x,pos.y,canvas.width,canvas.height);
        processing.image(canvas,pos.x,pos.y);
        return true;
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
        canvas.strokeCap(processing.ROUND);
        for (float i = startingX; i < max; i+=scaleFactor){
            if (i < sMax || i > endG){
                canvas.stroke(125,255,255,fadeGraph.fadeOut(0.01f));
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



        if (max > -2.88f && max < 2.88f) max -= 0.058f;
        //  println("x: " + max + " y: " + f(max));
        //   drawVector(traceGraphF);
        //  drawVector(traceGraphG);
    }


    public long factorial(int number) {
        var result = 1;

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

        return 0.2f*x;
        //(float) (double) randArr.get((int) x + 25);
    }

    public float g(float x){
        return x < 0 ? -4* sin(x): (float) -log(x);
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
        slowRotate.incEase(1.045f);
        slowRotate.doStuff();

      /* if (slowRotate.easing < 0.05 && !slowRotate.isEqual())
          slowRotate.incEase(1.045);


      if (!slowRotate.isEqual())
          slowRotate.incValue();


        if (slowRotate.isEqual())
          slowRotate.reset(); */


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
     * @param arrow  Vector to be drawn
     * Draws vector in Cartesian Space
     */
    public void drawVector(Arrow arrow){ //no need to graph and that stuff, just show vector!
        PVector v = arrow.vector; // aliases
        arrow.drawArc(canvas);
        canvas.colorMode(HSB);
        //float triangleSize;
        canvas.pushMatrix();


        arrow.doStuff(1.045f);


        float triangleSize = arrow.triangleSize; // VAR CAN BE USED!
        canvas.strokeWeight(arrow.triangleSize * 10.0f/12);


        float rotationAngle = v.heading();
        //should draw Ellipse but is drawing circle (FIX FOR OTHER RES OF CANVAS)
        float magnitude = arrow.getMag(sX,aspectRatio); // max < 0 ? sX*v.mag() - 16 : sX*v.mag(); //arrow.vectorMag; // 6 works...?! apply ease to this v.mag() - 6

        canvas.stroke(currentColor,255,255);
        canvas.strokeCap(processing.ROUND);



        /* text */
        canvas.fill(Useful.getColor(arrow.coordsSize,0,delVal),255,255);

        if (processing.TAU + rotationAngle > 3*processing.PI/2 && rotationAngle < 0)
            Useful.rotatedText(df.format(degrees(rotationAngle > 0 ? rotationAngle : processing.TAU + rotationAngle))+"°",canvas,sX*v.x/4,-sY*v.y/4,processing.PI-rotationAngle);
        else
            Useful.rotatedText(df.format(degrees(rotationAngle > 0 ? rotationAngle : processing.TAU + rotationAngle))+"°",canvas,sX*v.x/4.75f,-sY*v.y/4.75f,processing.PI-rotationAngle);

        canvas.textSize(80);
        canvas.fill(255,255,255);
        Useful.rotatedText(Useful.propFormat(v.mag()),canvas,sX*v.x/2 ,-sY*v.y/2,processing.PI-rotationAngle);
        /* text */

        canvas.rotate(-rotationAngle);

        canvas.line(0,0,magnitude,0);

        canvas.beginShape(processing.TRIANGLES);
        canvas.vertex(magnitude - triangleSize*1.5f + 8,-triangleSize);
        canvas.vertex(magnitude + 8, 0);
        canvas.vertex(magnitude - triangleSize*1.5f + 8,triangleSize);
        canvas.endShape();
        // canvas.triangle(magnitude-triangleSize*1.6,triangleSize,magnitude-triangleSize*1.6,-triangleSize,magnitude,0);

        canvas.popMatrix();

        arrow.addPoint(sX*v.x,-sY*v.y);
        arrow.graph(canvas,delVal); //delVAL
        /* overlaying text */
        canvas.textSize(42);
        canvas.fill(128,255,255);
        if (processing.PI-rotationAngle < 3*processing.PI/2 && processing.PI-rotationAngle > processing.PI/2)
            canvas.textAlign(LEFT,CENTER);
        else
            canvas.textAlign(RIGHT,CENTER);
        canvas.text(String.format("[cos(%s),sin(%s)]",df.format(v.x),df.format(v.y)),1.09f*sX*v.x,1.09f*-sY*v.y);
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
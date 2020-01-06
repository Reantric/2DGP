public class Scaling {
    boolean linesGone;
    float transparency;

    public Scaling(float transp){ //constructor overload later!
        this.linesGone = false;
        this.transparency = transp;
    }

    public Scaling(){
        this(255);
    }

    public float fadeOut(float multiplier){ //to fade in, 255 - fadeOut!!!!!!!!! DAMN YOUG ENIUS
        // println(Ttransp1 + " <<< transp1val ");
        if (transparency > 1.8){
            for (float t = 16; t > 0; t--){
                //println(transparency + " JohnJoe" + this);
                transparency -= multiplier*t/200;
            }
            return transparency;
        } else {
            linesGone = true;
            return 0;
        }
    }

    public float fadeIn(){
        return (255 - getTransp())*(122.0f/255);
    }

    public float getTransp(){
        return transparency;
    }

    public void reset(){
        transparency = 255;
        linesGone = false;
    }

    public boolean isFinished(){
        return linesGone;
    }



}

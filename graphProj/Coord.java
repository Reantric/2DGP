import java.util.Comparator;
import java.lang.Comparable;
import processing.core.PImage;

public class Coord implements Comparable<Coord>{
    public double yValue;
    public int hexCode;
    public String name;
    public PImage img;
    public Coord(double y, int hex, String n, PImage i){
        this.yValue = y;
        this.hexCode = hex;
        this.name = n;
        this.img = i;
    }

    public double getYCoord(){
        return yValue;
    }
    
    public void setYCoord(double y){
      this.yValue = y;
    }
    
    public String getLabel(){ //name is reserved :/
        return name;
    }
    
    public int getHex(){ 
        return hexCode;
    }
    
    public PImage getImg(){
      return img;
    }
    
    @Override
    public int compareTo(Coord c1) {
      if  (this.yValue < c1.yValue)
          return -1;
      else if (this.yValue > c1.yValue)
            return 1;
    return 0;
    }
    
    @Override
    public String toString(){
      return "Value: " + yValue + " Name: " + name + " Color: " + hexCode;
    }
}

class CoordValComparator implements Comparator<Coord> {
    @Override
    public int compare(Coord c1, Coord c2) {
        return Double.compare(c1.getYCoord(), c2.getYCoord());
    }
}

MObject tN;
void setupNarrator(){
 tN = new TextMObject(canvas,"Hello there",-790,-320,70,0);
}



void narration(){
  canvas.textAlign(LEFT);
  canvas.textSize(70);
  canvas.text("Sample text",-790,-420);
  tN.display();
}

void afterNarration(){

}

void narrate(){
  narration();
  afterNarration(); 
}

void test(){
  println("I exist!");
}

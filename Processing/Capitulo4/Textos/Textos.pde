PFont miFuente;

void setup(){
  size(600, 200);
  textAlign(CENTER, CENTER);
  miFuente = createFont("Arial Bold", 32);
}

void draw(){
  fill(0);
  textFont(miFuente);
  text("Programar reduce el colesterol", width/2, height/2);
}

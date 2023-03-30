int x, y;
int tamanioEmoticono = 400;
int xTranslate = 0;
int incremento = 1;

void setup(){
  size(600, 600);
  x = width/2;
  y = height/2;
  textAlign(CENTER, CENTER);
  textSize(30);
}

void draw(){
  background(255);
  translate(xTranslate, 0);
  text("¡SONRÍE! ES GRATIS", width/2, width-50);
  strokeWeight(1);
  fill(255, 255, 0);
  ellipse(x, y, tamanioEmoticono, tamanioEmoticono);
  fill(0);
  ellipse(x-70, y-70, 50, 70);
  ellipse(x+70, y-70, 50, 70);
  noFill();
  strokeWeight(10);
  arc(x, y+60, 200, 150, 0, PI);
  
  if(xTranslate + width/2 > width - tamanioEmoticono/2) incremento = -1;
  if(xTranslate + width/2 < tamanioEmoticono/2) incremento = 1;
  xTranslate +=incremento;
}

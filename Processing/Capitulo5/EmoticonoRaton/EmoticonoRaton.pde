int x, y, offsetX, offsetY;
int tamanioEmoticono = 400;

void setup(){
  size(1000, 600);
  x = width/2;
  y = height/2;
}

void draw(){
  background(255);
  if(mousePressed && dentroEmoticono(x, y)){
    x = mouseX - offsetX;
    y = mouseY - offsetY;
  }
  pintaEmoticono();
}

void mousePressed(){
  offsetX = mouseX - x;
  offsetY = mouseY - y;
}

void pintaEmoticono(){
  strokeWeight(1);
  fill(255, 255, 0);
  ellipse(x, y, tamanioEmoticono, tamanioEmoticono);
  fill(0);
  ellipse(x-70, y-70, 50, 70);
  ellipse(x+70, y-70, 50, 70);
  noFill();
  strokeWeight(10);
  arc(x, y+60, 200, 150, 0, PI);
}

boolean dentroEmoticono(int x, int y){
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < tamanioEmoticono/2 ) {
    return true;
  } else {
    return false;
  }
}

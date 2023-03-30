int tamanioEmoticono = 400;
int x, y;

void setup() {
  size(1000, 600);
  x = width/2;
  y = height/2;
}

void draw() {
  background(255);
  pintaEmoticono();
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case UP: y--; break;
    case DOWN: y++; break;
    case LEFT: x--; break;
    case RIGHT: x++; break;
    }
  }
}

void pintaEmoticono() {
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

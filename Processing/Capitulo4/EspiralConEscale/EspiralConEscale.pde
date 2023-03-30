void setup() {
  size(500, 400);
}

void draw() {
  translate(width/2, height/2);
  scale(6);
  for (int x = 0; x < 100; x++){
    rotate(0.1);
    point(x, 0);
  }
}

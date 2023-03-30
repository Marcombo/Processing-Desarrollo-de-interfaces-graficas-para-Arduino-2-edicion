void setup() {
  size(400,400,P3D);
  background(255);
  fill(100);
}

void draw() {
  translate(width/2, height/2, 0);
  rotateX(-0.4);
  box(150);
}

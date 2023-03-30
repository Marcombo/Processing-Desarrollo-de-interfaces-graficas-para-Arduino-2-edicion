void setup() {
  size(400,400,P3D);
  background(255);
  noFill();
}

void draw() {
  translate(width/2, height/2, 0);
  rotateX(-0.4);
  sphere(150);
}
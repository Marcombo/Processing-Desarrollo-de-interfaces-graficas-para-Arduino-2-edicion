float y;

void setup() {
  size(400,400,P3D);
  noFill();
}

void draw() {
  background(255);
  translate(width/2, height/2, 0);
  rotateY(y);
  y += 0.01;
  sphere(150);
}
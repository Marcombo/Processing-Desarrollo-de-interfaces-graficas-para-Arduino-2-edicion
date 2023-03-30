void setup() {
  size(400,400,P3D);
  rectMode(CENTER);
  noStroke();
  fill(124);
}

void draw() {
  background(255);
  lights();
  translate(width/2, height/2, 0);
  rotateX(-0.4);
  sphere(150);
}
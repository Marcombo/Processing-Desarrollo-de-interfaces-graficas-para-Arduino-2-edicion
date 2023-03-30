void setup() {
  size(400,400,P3D);
  rectMode(CENTER);
  noStroke();
}

void draw() {
  background(255);
  directionalLight(255, 0, 0, 1, -1, 0);
  translate(width/2, height/2, 0);
  rotateX(-0.4);
  sphere(150);
}
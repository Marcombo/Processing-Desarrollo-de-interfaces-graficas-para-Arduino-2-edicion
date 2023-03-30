float anguloX;
void setup() {
  size(400, 400, P3D);
  rectMode(CENTER);
}
void draw() {
  background(125);
  translate(width/2, height/2, 0);
  rotateX(anguloX);
  rect(0, 0, 100, 200);
  anguloX+=0.25;
}

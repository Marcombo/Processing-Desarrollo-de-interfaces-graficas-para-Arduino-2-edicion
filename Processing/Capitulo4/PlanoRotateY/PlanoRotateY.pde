float anguloY;
void setup() {
  size(400, 400, P3D);
  rectMode(CENTER);
}
void draw() {
  background(125);
  translate(width/2, height/2, 0);
  rotateY(anguloY);
  rect(0, 0, 100, 200);
  anguloY+=0.25;
}

float anguloZ;

void setup() {
  size(400,400,P3D);
  rectMode(CENTER);
}

void draw() {
  background(125);
  translate(width/2,height/2,0);
  rotateZ(anguloZ);
  rect(0,0,100,200);

  anguloZ+=0.25;
}
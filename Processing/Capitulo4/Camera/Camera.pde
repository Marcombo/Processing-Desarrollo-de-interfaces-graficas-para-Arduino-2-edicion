float x;

void setup() {
  size(640, 360, P3D);
  noFill();
}

void draw() {
  background(255);
  camera(x, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  translate(width/2, height/2, 0);
  box(200);
  if(x > width) x = width;
  else x++;
}
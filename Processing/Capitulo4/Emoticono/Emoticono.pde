int x, y;

void setup(){
  size(600, 600);
  x = width/2;
  y = height/2;
}

void draw(){
  ellipse(x, y, 400, 400);
  ellipse(x-70, y-70, 50, 70);
  ellipse(x+70, y-70, 50, 70);
  arc(x, y+60, 200, 150, 0, PI);
}

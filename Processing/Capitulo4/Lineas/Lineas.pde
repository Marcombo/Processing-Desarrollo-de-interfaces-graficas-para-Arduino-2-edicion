int x1, x2, y1, y2; 

void setup(){
  size(300, 300);
}

void draw(){
  x2 = x1;
  y2 = y1;
  x1 = int(random(width));
  y1 = int(random(height));
  line(x1, y1, x2, y2);
}
int x, y, grosor;

void setup(){
  size(300, 200);
}

void draw(){
    x = int(random(width));
    y = int(random(height));
    grosor = int(random(20));
    strokeWeight(grosor);
    point(x, y);
}

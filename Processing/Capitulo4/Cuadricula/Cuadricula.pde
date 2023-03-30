int ladoCuadricula = 20;

void setup() {
  size(300, 300);
}

void draw() {
  for(int x = 0; x <= width; x += ladoCuadricula){
    line(x, 0, x, height);
  }
  for(int y = 0; y <= height; y += ladoCuadricula){
    line(0, y, width, y);
  } 
}

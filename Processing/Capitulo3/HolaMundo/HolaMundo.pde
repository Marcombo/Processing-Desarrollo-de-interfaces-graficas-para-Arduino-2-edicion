void setup(){
  size(300, 100);
  surface.setTitle("Hola Mundo");
  println("Ancho: " + width, "Alto: " + height);
}

void draw(){
  background(0);
  text("Hola Mundo", mouseX, mouseY);
}

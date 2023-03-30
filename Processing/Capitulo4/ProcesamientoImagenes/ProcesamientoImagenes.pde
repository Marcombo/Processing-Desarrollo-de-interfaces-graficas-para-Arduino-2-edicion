PImage miImagen;

int anchoImagen;

void setup() { 
  size(800,150);
  anchoImagen = width/4;
  miImagen = loadImage("cervatillo.jpg");
  miImagen.resize(anchoImagen, 0);
}

void draw() { 
  tint(255, 255, 255);
  image(miImagen, 0, 0);
  tint(255, 255, 0);
  image(miImagen, anchoImagen, 0);
  tint(255, 0, 255);
  image(miImagen, anchoImagen*2, 0);
  tint(0, 255, 255);
  image(miImagen, anchoImagen*3, 0);
}

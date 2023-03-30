import gab.opencv.*;

PImage img;
OpenCV opencv;

int umbral = 127;
PFont fuente;
ArrayList<Contour> contornos;

void settings(){
  img = loadImage("hoja.jpg"); 
  size(img.width, img.height);
}

void setup() {
  opencv = new OpenCV(this, img);
  fuente = createFont("Arial Bold", 24);
  textFont(fuente);
}

void draw() {
  background(255);

  opencv.loadImage(img);
  opencv.threshold(umbral);
  contornos = opencv.findContours();
  
  image(img, 0, 0);
  pintaContornos();
  escribeUmbral();
}

void pintaContornos(){
  noFill();
  strokeWeight(3);
  stroke(0, 255, 0);
  
  for (Contour contorno : contornos) {
    contorno.draw();
  }
}

void escribeUmbral(){
  fill(0);
  text(umbral, 4, 24);
}

void keyPressed(){
  if (key == CODED){
    switch(keyCode){
      case LEFT:  umbral--; break;
      case RIGHT: umbral++; break;
    }
  }
  if (umbral > 255) umbral = 255;
  if (umbral < 0) umbral = 0;
}

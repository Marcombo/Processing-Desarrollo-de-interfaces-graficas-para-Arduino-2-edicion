import gab.opencv.*;

PImage  img;
OpenCV opencv;

int umbral = 127;
PFont fuente;

void setup() {
  img = loadImage("hoja.jpg");
  size(450, 169);
  opencv = new OpenCV(this, img);
  fuente = createFont("Arial Bold", 24);
  textFont(fuente);
}

void draw(){
  opencv.loadImage(img);
  opencv.threshold(umbral);
  
  image(img, 0, 0);
  image(opencv.getOutput(),img.width,0);
  escribeUmbral();
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

void escribeUmbral(){
  fill(0);
  text(umbral, 4, 24);
}

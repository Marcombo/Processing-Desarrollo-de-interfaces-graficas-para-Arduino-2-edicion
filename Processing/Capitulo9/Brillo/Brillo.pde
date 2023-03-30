import gab.opencv.*;

PImage img;
OpenCV opencv;

int brillo;
PFont fuente;

void setup(){
  size(800, 600);
  img = loadImage("Lisboa.jpg");
  opencv = new OpenCV(this, img, true);
  
  fuente = createFont("Arial Bold", 24);
  textFont(fuente);
}

void draw(){
  opencv.loadImage(img);
  opencv.brightness(brillo);
  image(opencv.getOutput(),0,0);
  escribeNivelBrillo();
}

void keyPressed(){
  if (key == CODED){
    switch(keyCode){
      case LEFT:  brillo--; break;
      case RIGHT: brillo++; break;
    }
  }
  if (brillo > 255) brillo = 255;
  if (brillo < -255) brillo = -255;
}

void escribeNivelBrillo(){
  fill(0);
  text(brillo, 4, 24);
}

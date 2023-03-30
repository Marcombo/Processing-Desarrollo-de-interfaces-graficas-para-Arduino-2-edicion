import gab.opencv.*;
import java.awt.Rectangle;

PImage img;
OpenCV opencv;

int umbral = 85;
ArrayList<Contour> contornos;
Rectangle rect;
String tipoTaco="";

float AREA_MINIMA = 1000;
float AREA_MAXIMA = 10000;
float AREA9 = 5000;
float AREA6 = 1000;

void setup() {
  img = loadImage("tacos1.jpg"); 
  size(436, 245);
  opencv = new OpenCV(this, img);
  
  strokeWeight(3);
  textSize(12);
  fill(0);
  textAlign(CENTER, CENTER);

  opencv.threshold(umbral);
  contornos = opencv.findContours();
}

void draw() {
  image(img, 0, 0);
  
  for (Contour contorno : contornos){
    if(contorno.area() > AREA_MINIMA && contorno.area() < AREA_MAXIMA){
      if(contorno.area() > AREA9) tipoTaco = "Nº9";
      else if(contorno.area() > AREA6) tipoTaco = "Nº6";
      
      rect = contorno.getBoundingBox();
      text(tipoTaco, rect.x+rect.width/2, rect.y+rect.height/2);
    }
  }
}

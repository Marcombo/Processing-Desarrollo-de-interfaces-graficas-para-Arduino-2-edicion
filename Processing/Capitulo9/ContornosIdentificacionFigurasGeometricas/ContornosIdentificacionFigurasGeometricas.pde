import gab.opencv.*;
import java.awt.Rectangle;

PImage img;
OpenCV opencv;

int umbral = 75;
ArrayList<Contour> contornos;
Rectangle rect;
Contour poligono;
String tipoPoligono;

void setup() {
  img = loadImage("figurasGeometricas.png"); 
  size(945, 302);
  opencv = new OpenCV(this, img);
  
  strokeWeight(3);
  textSize(20);
  fill(0);
  textAlign(CENTER, CENTER);
  
  opencv.threshold(umbral);
  contornos = opencv.findContours();
}

void draw() {
  image(img, 0, 0);
  for (Contour contorno : contornos){
    poligono = contorno.getPolygonApproximation();
    switch(poligono.numPoints()){
      case 3: tipoPoligono = "TRIÁNGULO"; break;
      case 4: tipoPoligono = "CUADRADO"; break;
      default: tipoPoligono = "CÍRCULO";
    }

    rect = contorno.getBoundingBox();
    text(tipoPoligono, rect.x+rect.width/2, rect.y+rect.height/2);
  }
}

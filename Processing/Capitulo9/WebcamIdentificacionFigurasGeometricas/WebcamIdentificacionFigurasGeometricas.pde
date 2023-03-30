import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture camara;
OpenCV opencv;

ArrayList<Contour> contornos;
Rectangle rect;
Contour poligono;
String tipoPoligono = "";

float areaContorno;
int AreaContornoMinimo = 20000;
int AreaContornoMaximo = 90000;

int umbral = 127;

void setup() {
  size(640, 480);
  opencv = new OpenCV(this, 640, 480);
  
  strokeWeight(3);
  fill(255);
  textAlign(CENTER, CENTER);
  
  camara = new Capture(this, 640, 480);
  camara.start();
}

void draw() {
  image(camara, 0, 0 );
  
  opencv.loadImage(camara);
  opencv.threshold(umbral);
  contornos = opencv.findContours();
  
  for (Contour contorno : contornos){
    areaContorno = contorno.area();
    if (areaContorno > AreaContornoMinimo && areaContorno < AreaContornoMaximo){
      poligono = contorno.getPolygonApproximation();
      switch(poligono.numPoints()){
        case 3: tipoPoligono = "TRIÁNGULO"; break;
        case 4: tipoPoligono = "CUADRADO"; break;
        case 5: tipoPoligono = "PENTÁGONO";
      }
          
      rect = contorno.getBoundingBox();
      textSize(int(areaContorno/2500));
      text(tipoPoligono, rect.x+rect.width/2, rect.y+rect.height/2);
    }
  }
}

void captureEvent(Capture c) {
  c.read();
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
  println("UMBRAL: " + umbral);
}

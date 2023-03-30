import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture camara;
OpenCV opencv;
Rectangle[] caras;

int areaCaraMinima = 1000;

int[] resolucion = {320, 240};

void setup() {
  opencv = new OpenCV(this, resolucion[0], resolucion[1]);
  size(640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);

  camara = new Capture(this,resolucion[0], resolucion[1]);
  camara.start();
}

void draw() {
  scale(2);
  image(camara, 0, 0 );
  
  opencv.loadImage(camara);
  caras = opencv.detect();
  for (Rectangle cara : caras) {
    if (cara.width * cara.height > areaCaraMinima) 
      rect(cara.x, cara.y, cara.width, cara.height);
  }
}

void captureEvent(Capture camara) {
  camara.read();
}

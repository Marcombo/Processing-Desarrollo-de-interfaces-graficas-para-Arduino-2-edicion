import gab.opencv.*;
import processing.video.*;

Capture camara;
OpenCV opencv;

void setup() {
  size(640, 480);
  opencv = new OpenCV(this, 640, 480);
    
  fill(255, 0, 0);
  
  opencv.startBackgroundSubtraction(5, 30, 0.5);
    
  camara = new Capture(this, 640, 480);
  camara.start();
}

void draw() {
  image(camara, 0, 0 );
  opencv.loadImage(camara);
  
  opencv.updateBackground();

  for (Contour contorno : opencv.findContours()) {
    contorno.draw();
  }
}

void captureEvent(Capture c) {
  c.read();
}

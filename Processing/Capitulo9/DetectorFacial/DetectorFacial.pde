import gab.opencv.*;
import java.awt.Rectangle;

OpenCV opencv;
Rectangle[] caras;

void setup() {
  size(384, 512);
  opencv = new OpenCV(this, "Einstein.jpg");
  image(opencv.getOutput(), 0, 0);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  caras = opencv.detect();
  for (Rectangle cara : caras){
    rect(cara.x, cara.y, cara.width, cara.height);
  }
}

void draw() {}

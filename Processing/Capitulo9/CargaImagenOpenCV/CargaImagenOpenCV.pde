import gab.opencv.*;

OpenCV opencv;
PImage imagen;

void setup() {
  size(800, 600);
  opencv = new OpenCV(this, "Lisboa.jpg", true);
  imagen = opencv.getOutput();
  image(imagen, 0, 0);
}

void draw() {
}

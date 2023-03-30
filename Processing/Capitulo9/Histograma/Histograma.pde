import gab.opencv.*;

OpenCV opencv;

Histogram histograma;
PImage img;

void setup() {
  size(800, 300);
  img = loadImage("aves.jpg");
  opencv = new OpenCV(this, img);

  histograma = opencv.findHistogram(opencv.getGray(), 256);
  
  background(255);
  scale(0.5);
  image(img, 0, 0);
  histograma.draw(img.width, 0, img.width, img.height);
}

void draw() {}

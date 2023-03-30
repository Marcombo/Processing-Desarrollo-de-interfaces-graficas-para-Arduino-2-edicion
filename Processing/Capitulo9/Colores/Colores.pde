import gab.opencv.*;

OpenCV opencv;
PImage  img, red, green, blue;
void setup() {
  size(1200, 300);
  img = loadImage("playa.jpg");
  opencv = new OpenCV(this, img, true);  
 
  red = opencv.getSnapshot(opencv.getR());
  green = opencv.getSnapshot(opencv.getG());
  blue = opencv.getSnapshot(opencv.getB());
  
  scale(0.5);
  image(red, 0, 0);
  image(green, img.width, 0);
  image(blue, img.width*2, 0);
}

void draw() {}

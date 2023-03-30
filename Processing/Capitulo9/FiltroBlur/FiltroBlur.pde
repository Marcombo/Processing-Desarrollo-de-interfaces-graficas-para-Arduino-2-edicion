import gab.opencv.*;

OpenCV opencv;
PImage  img, blur;

int area = 12;

void setup() {
  size(800, 300);
  img = loadImage("playa.jpg");
  opencv = new OpenCV(this, img, true);  

  opencv.blur(area);  
  
  scale(0.5);
  image(img, 0, 0);
  blur = opencv.getOutput();
  image(blur, img.width, 0);
}

void draw() {}

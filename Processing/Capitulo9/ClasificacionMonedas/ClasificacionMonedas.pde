import processing.serial.*;
import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Serial puerto; 
Capture camara;
OpenCV opencv;

ArrayList<Contour> contornos;
Rectangle rect;

float area;
int moneda1_MIN = 4000;
int moneda1_MAX = 8000;
int moneda5_MIN = 8000;
int moneda5_MAX = 12000;
String moneda = "";
PFont miFuente;

int umbral = 100;

void setup() {
  String nombrePuerto  = Serial.list()[0];
  puerto = new Serial(this, nombrePuerto, 115200);
  
  size(640, 480);
  opencv = new OpenCV(this, 640, 480);
  
  strokeWeight(2);
  textAlign(CENTER, CENTER);
  miFuente = createFont("Arial Bold", 24);
  textFont(miFuente);
  
  camara = new Capture(this, 640, 480);
  camara.start();
}

void draw() {
  image(camara, 0, 0 );
  
  opencv.loadImage(camara);
  opencv.threshold(umbral);
  contornos = opencv.findContours();
  
  for (Contour contorno : contornos){
    area = contorno.area();
    //println(area);
    //noFill();
    //contorno.draw();
    if (area > moneda1_MIN && area < moneda5_MAX){
      if (area > moneda1_MIN && area < moneda1_MAX){
        moneda = "1";
        puerto.write(0);
      }
      if (area > moneda5_MIN && area < moneda5_MAX){
        puerto.write(90);
        moneda = "5";
      }
          
      noFill();
      contorno.draw();
      rect = contorno.getBoundingBox();
      rect(rect.x, rect.y, rect.width, rect.height);
      fill(255);
      text(moneda, rect.x+rect.width/2, rect.y+rect.height/2);
      
      delay(20);
      break;
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

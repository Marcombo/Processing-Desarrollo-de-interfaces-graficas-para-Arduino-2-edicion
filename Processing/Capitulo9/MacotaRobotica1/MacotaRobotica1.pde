import processing.serial.*;
import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Serial puerto; 
Capture camara;
OpenCV opencv;

Rectangle[] caras;
Rectangle cara;
int caraX, caraY;
int areaCaraMinima = 1000;

int[] resolucion = {320, 240};

int posicionXServo = 90;
int posicionYServo = 90;
int margenXServo = 25;
int margenYServo = 15;

void setup() {
  String nombrePuerto  = Serial.list()[0];
  puerto = new Serial(this, nombrePuerto, 115200);
  
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
  image(camara, 0, 0);
  
  opencv.loadImage(camara);
  caras = opencv.detect();
  if (caras.length > 0){
    cara = caras[0];
    if (cara.width * cara.height > areaCaraMinima){ 
      rect(cara.x, cara.y, cara.width, cara.height);
      caraX = 2*(cara.x + cara.width/2);
      caraY = 2*(cara.y + cara.height/2);
      if(abs(caraX - width/2) > margenXServo){
        if(caraX - width/2 > 0) posicionXServo--;
        else posicionXServo++;
        puerto.write("SERVO_X" + "=" + posicionXServo + "\n");
      }
    
      if(abs(caraY - height/2) > margenYServo){
        if(caraY - height/2 > 0) posicionYServo++;
        else posicionYServo--;
        puerto.write("SERVO_Y" + "=" + posicionYServo + "\n");
      }
      delay(20);
    }
  }
}

void captureEvent(Capture camara){ 
  camara.read();
}

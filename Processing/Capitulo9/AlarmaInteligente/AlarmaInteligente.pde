import processing.serial.*;
import gab.opencv.*;
import processing.video.*;

Serial puerto;
Capture camara;
OpenCV opencv;

boolean estado = false;

int areaMinima = 10000;

int intervalo = 10000;
int tiempo;

int numeroImagen;

PFont miFuente;

void setup() {
  puerto = new Serial(this, "COM7", 9600);
  
  size(640, 480);
  opencv = new OpenCV(this, 640, 480);
    
  fill(255, 0, 0);
  miFuente = createFont("Arial Bold",32);
  textFont(miFuente);
  textAlign(CENTER, CENTER);
  
  opencv.startBackgroundSubtraction(5, 30, 0.5);
    
  camara = new Capture(this, 640, 480);
  camara.start();
  
  delay(5000);
}

void draw() {
  image(camara, 0, 0 );
  if (estado){
    if ((millis() - tiempo) > intervalo){
      puerto.write(0);
      estado = false;
    }
    else text("PULSE PARA REARMAR", width/2, height/2);
  }
  else{
    opencv.loadImage(camara);
    opencv.updateBackground();
    for (Contour contorno : opencv.findContours()) {
      //printl(contorno.area());
      //contorno.draw();
      if (contorno.area() > areaMinima){
        puerto.write(1);
        camara.save("ladron"+numeroImagen+".png");
        estado = true;
        numeroImagen++;
        tiempo = millis();
        break;
      }
    }
  }
}

void mousePressed(){
  puerto.write(0);
  estado = false;
}

void captureEvent(Capture c) {
  c.read();
}

import processing.serial.*;

Serial puerto;
String datosLeidos;
String[] rotaciones;
float rotacionX, rotacionY, rotacionZ;

void setup() {
  size(800, 600, P3D);
  fill(200, 150, 50);
  //Se crea el puerto de comunicaciones con Arduino
  puerto = new Serial(this, Serial.list()[0], 115200);
  puerto.bufferUntil('\n');
}

void draw() {
  background(255);
  lights();
  // Se sitúan los ejes de coordenadas en el centro de la pantalla
  translate(width/2, height/2, 0); 
  //Se rota
  rotateX(rotacionX);  
  rotateY(rotacionY);  
  rotateZ(rotacionZ); 
  //Se dibuja el cubo
  box(420, 210, 95); 
}

void serialEvent( Serial puerto) {
  datosLeidos = puerto.readStringUntil('\n');
  rotaciones = split(datosLeidos, ",");
  rotacionX = radians(float(rotaciones[0]));
  rotacionY = radians(float(rotaciones[1]));
  rotacionZ = radians(float(rotaciones[2]));
}

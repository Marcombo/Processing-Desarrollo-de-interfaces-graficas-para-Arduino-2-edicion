import meter.*;
import processing.serial.*; 

Serial puerto;
Meter termometro;
int temperatura=0;

void setup() {
  size(500, 450);
  background(255); 
  configuratermometro();
  puerto = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  termometro.updateMeter(temperatura);
}

void serialEvent(Serial puerto) {
  temperatura = int(puerto.read());
}
  
void configuratermometro(){
  termometro = new Meter(this, 25, 100); // se crea el objeto termometro
  
  termometro.setFrameColor(255); //color de fondo del termómetro

  // Título del termometro y tamaño de fuente utilizada
  termometro.setTitleFontSize(20);
  termometro.setTitle("Temperatura (ºC)");

  
  // Escala utilizada, tamaño y color de la fuente con la que se dibuja
  String[] escala = {"0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50"};
  termometro.setScaleLabels(escala);
  termometro.setScaleFontSize(18);
  termometro.setScaleFontColor(color(0, 0, 255));
  
  // Color y ancho del arco
  termometro.setArcColor(color(0, 0, 255));
  termometro.setArcThickness(15);

  termometro.setNeedleThickness(5); //ancho de la aguja
  
  // Valores máximo y mínimo que se van a medir
  termometro.setMinInputSignal(0);
  termometro.setMaxInputSignal(50);
}

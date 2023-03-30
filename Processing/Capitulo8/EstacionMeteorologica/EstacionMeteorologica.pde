import meter.*;
import processing.serial.*; 

Serial puerto; 
Meter termometro, higrometro;
String[] temperaturaHumedad;
int temperatura, humedad;

void setup() {
  size(930, 450);
  background(255);
  
  fill(0, 0, 255);
  textSize(30);
  textAlign(CENTER, CENTER);
  
  //Cambiar por el puerto bluetooth correspondiente !!
  puerto = new Serial(this, "COM7", 9600); 
  puerto.bufferUntil('\n'); 
  
  configuratermometro();
  configurahigrometro();
}

void draw() {
  background(255);
  text("ESTACIÓN METEOROLÓGICA", width/2, 30);
  termometro.updateMeter(temperatura);
  higrometro.updateMeter(humedad);
}

void serialEvent( Serial puerto) {
  temperaturaHumedad = split(puerto.readStringUntil('\n'), ",");
  temperatura = int(trim(temperaturaHumedad[0]));
  humedad = int(trim(temperaturaHumedad[1]));
}
  
void configuratermometro(){
  //Se crea el termómetro
  termometro = new Meter(this, 25, 100);
  
  //Color de fondo del termómetro
  termometro.setFrameColor(255); 

  // Título del termometro y tamaño de fuente utilizada
  termometro.setTitleFontSize(20);
  termometro.setTitle("Temperatura (ºC)");

  
  // Escala utilizada, tamaño y color de la fuente con la que se dibuja
  String[] scaleLabelsT = {"0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50"};
  termometro.setScaleLabels(scaleLabelsT);
  termometro.setScaleFontSize(18);
  termometro.setScaleFontColor(color(0, 0, 255));
  
  // Color y ancho del arco del termómetro
  termometro.setArcColor(color(0, 0, 255));
  termometro.setArcThickness(15);

  //ancho de la aguja
  termometro.setNeedleThickness(5); 
  
  // Valores máximo y mínimo que se van a medir con el termómetro
  termometro.setMinInputSignal(0);
  termometro.setMaxInputSignal(50);
}

void configurahigrometro(){
  //Se obtienen las coordenadas en la que está situado el termometro y su ancho
  //Se utilizan para situar el higrómetro a su derecha
  int termometroX = termometro.getMeterX();
  int termometroY = termometro.getMeterY();
  int termometroAncho = termometro.getMeterWidth();
  higrometro = new Meter(this,termometroX + termometroAncho, termometroY); // se crea el objeto higrómetro
  
  higrometro.setFrameColor(255); //color de fondo del higrómetro

  // Título del higrómetro y tamaño de fuente utilizada
  higrometro.setTitleFontSize(20);
  higrometro.setTitle("Humedad (%)");

  
  // Escala utilizada, tamaño y color de la fuente con la que se dibuja
  String[] scaleLabelsT = {"0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"};
  higrometro.setScaleLabels(scaleLabelsT);
  higrometro.setScaleFontSize(18);
  higrometro.setScaleFontColor(color(0, 0, 255));
  
  // Color y ancho del arco del higrómetro
  higrometro.setArcColor(color(0, 0, 255));
  higrometro.setArcThickness(15);

  higrometro.setNeedleThickness(5); //ancho de la aguja
  
  // Valores máximo y mínimo que se van a medir con el higrómetro
  higrometro.setMinInputSignal(0);
  higrometro.setMaxInputSignal(100);
}

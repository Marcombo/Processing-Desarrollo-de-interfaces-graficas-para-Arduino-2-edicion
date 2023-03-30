import processing.serial.*;
import controlP5.*;

Serial puerto; 
int valor; 
int[] valores;

ControlP5 cp5;
DropdownList menuPuertosCOM;
Textlabel etiquetaZoom;
Toggle interruptorZoom;
int zoom = 1;

void setup() 
{
  size(1200, 500);
  
  cp5 = new ControlP5(this);
  //Menú desplegable con los puertos COM disponibles
  menuPuertosCOM = cp5.addDropdownList("com");
  menuPuertosCOM.setPosition(50, 20);
  menuPuertosCOM.setSize(50,200);
  String[] puertosCOM = Serial.list();
  for (int i=0; i<puertosCOM.length; i++) {
    menuPuertosCOM.addItem(puertosCOM[i], i);
  }
  //Interruptor con el que se selecciona el nivel de zoom
  interruptorZoom = cp5.addToggle("zoom");
  interruptorZoom.setPosition(width-100, 20);
  interruptorZoom.setSize(50,20);
  interruptorZoom.setValue(false);
  interruptorZoom.setMode(ControlP5.SWITCH);
  //Etiqueta que muestra el nivel de zoom seleccionado
  etiquetaZoom = cp5.addTextlabel("etiqueta");
  etiquetaZoom.setText("X1");
  etiquetaZoom.setPosition(width-140, 20);
  etiquetaZoom.setFont(createFont("Times New Roman",18));
  zoom = 1;
   
  //Array que almacena los valores de las tensiones que se muestran en pantalla
  valores = new int[width];
}

void draw()
{
  background(0);

  pintaTitulo();
  pintaRejilla();
  pushValor(valor);
  pintaTrazo();
}

void serialEvent( Serial puerto) {
  valor = int(trim(puerto.readStringUntil('\n')))*zoom;
}

//Almacena un nuevo valor en el array de valores
void pushValor(int valor) {
  for (int i = 0; i < width-1; i++) valores[i] = valores[i+1];
  valores[width-1] = valor;
}

void pintaTitulo(){
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(255, 255, 255, 50);
  text("OSCILOSCOPIO", width/2, height/2);
}

//Dibuja en pantanlla la evolución de la tensión en el tiempo
//Para ello pinta líneas entre valores de tensión consecutivos
void pintaTrazo() {
  stroke(250, 250, 0);
  strokeWeight(2);
  int x0 = 0;
  int y0 = int(map(valores[0], 0, 1023, height, 0));
  for (int i = 0; i < width-1; i++) {
    int x1 = i;
    int y1 = int(map(valores[i], 0, 1023, height, 0));
    line(x0, y0, x1, y1);
    x0 = x1;
    y0 = y1;
  }
}

//Dibuja la rejilla
void pintaRejilla() {
  stroke(150, 150, 180);
  fill(150, 150, 180);
  strokeWeight(1);
  textSize(15);
  for(int i = 0; i<= height; i += height/5){
    line(0, i, width, i);
    text(str((float(height) - i)/100/zoom) + " V.", 20, i - 15);
  }
}

//Gestiona los eventos de los elementos ControlP5
void controlEvent(ControlEvent evento) {
  int valor = int(evento.getValue());
  String nombre = evento.getName();
  if(nombre == "com"){
      //Establece las comunicaciones con Arduino
    puerto = new Serial(this, Serial.list()[valor], 115200);
    puerto.bufferUntil('\n');
  }
  else if(nombre == "zoom" && etiquetaZoom != null){
    if(valor == 0){
      etiquetaZoom.setText("X1");
      zoom = 1;
    }
    else if(valor == 1){
      etiquetaZoom.setText("X5");
      zoom = 5;
    }
  }
}
 

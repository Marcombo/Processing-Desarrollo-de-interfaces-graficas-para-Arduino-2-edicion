import processing.serial.*;

Serial puerto;
int posicionMando;

int anchoPelota=20;
int velocidadXPelota = 6;
int velocidadYPelota = 6;
int posXPelota = -anchoPelota;
int posYPelota = -anchoPelota;

int velocidadRaqueta = 6;
int anchoRaqueta=75;
int altoRaqueta=10;
int posXRaqueta;
int posYRaqueta;

//No hay pelota en pantalla inicialmente
boolean nuevoJuego=false;

void setup(){
  size(400,500);
  textAlign(CENTER, CENTER);
  textSize(20);
  //Se coloca la raqueta abajo en el centro
  posXRaqueta=width/2 - anchoRaqueta/2;
  posYRaqueta=height - altoRaqueta;
  
  //Se crea el puerto de comunicaciones con Arduino
  puerto = new Serial(this, Serial.list()[0], 115200);
  puerto.bufferUntil('\n');
}

void draw(){
  background(125);
  text("FRONTÓN", width/2, height/2);
  //Se sitúa la pelota en una posición aleatoria en la parte superior de la ventana
  if (nuevoJuego){
    posXPelota=int(random(width));
    posYPelota=int(random(height/2));
    nuevoJuego=false;
  }  
  pintaRaqueta();
  pintaPelota();
}

void pintaPelota(){
  //La pelota rebota en la izquierda y en la derecha
  if(posXPelota <=0 || posXPelota >= width){
    velocidadXPelota = -velocidadXPelota;
  }
  //La pelota rebota arriba 
  if(posYPelota <=0){
    velocidadYPelota = -velocidadYPelota;
  }
  //La pelota rebota en la raqueta
  if((posXPelota >= posXRaqueta && posXPelota <=posXRaqueta + anchoRaqueta) &&
     (posYPelota >= posYRaqueta && posYPelota <=posYRaqueta + altoRaqueta)){
     velocidadYPelota = -velocidadYPelota;
  }
  //Se actualiza la posición de la pelota
  posXPelota = posXPelota + velocidadXPelota;
  posYPelota = posYPelota + velocidadYPelota;
  //Se pinta la pelota
  ellipse(posXPelota,posYPelota,anchoPelota,anchoPelota);
}

void pintaRaqueta(){ 
  //Se actualiza la posición de la raqueta
  posXRaqueta = int(map(posicionMando, 0, 1023, 0, width - anchoRaqueta));
  rect(posXRaqueta, posYRaqueta, anchoRaqueta, altoRaqueta);
}


void keyPressed(){
  if (key == ' ') nuevoJuego=true; 
}

void serialEvent( Serial puerto) {
  posicionMando = int(trim(puerto.readStringUntil('\n')));
}

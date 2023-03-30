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

int anchoLadrillo = 50;
int altoLadrillo = 20;
int posXLadrillo;
int posYLadrillo;
int numeroFilas = 5;
int numeroColumnas = 8;
int alturaPrimeraFila = 80;
color[] colores  = {#FF0000, #00FF00, #FFFF00, #0000FF, #00FFFF};
boolean[] visibilidadLadrillos = new boolean[numeroFilas*numeroColumnas];

//No hay ninguna pelota en pantalla inicialmente
boolean nuevoJuego=false;

void setup(){
  size(400,500);
  //Se coloca la raqueta abajo en el centro
  posXRaqueta=width/2 - anchoRaqueta/2;
  posYRaqueta=height - altoRaqueta;
  
  //Se inicializa la matriz para que se visualicen todos los ladrillos
  for(int i = 0; i < visibilidadLadrillos.length; i++) visibilidadLadrillos[i] = true;
  
  //Se crea el puerto serie
  puerto = new Serial(this, Serial.list()[0], 115200);
  puerto.bufferUntil('\n');

}

void draw(){
  background(125);
  //Se sitúa la pelota en una posición aleatoria al pulsar el espacio
  if (nuevoJuego){
    posXPelota = int(random(width));
    posYPelota = height/2;
    nuevoJuego = false;
  }
  pintaLadrillos();
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
  //la pelota rebota en la raqueta
  if((posXPelota >= posXRaqueta && posXPelota <=posXRaqueta + anchoRaqueta) &&
     (posYPelota >= posYRaqueta && posYPelota <=posYRaqueta + altoRaqueta)){
     velocidadYPelota = -velocidadYPelota;
  }
  //La pelota rebota en un ladrillo
  for(int fila = 0; fila < numeroFilas; fila++){
    for(int columna = 0; columna < numeroColumnas; columna++){
      posXLadrillo = columna*anchoLadrillo;
      posYLadrillo = fila*altoLadrillo+alturaPrimeraFila;
      //solo puedo rebotar en los ladrillos cuyo visibles
      if(visibilidadLadrillos[fila*numeroColumnas+columna]){
        //la pelota rebota en un ladrillo
        if((posXPelota >= posXLadrillo && posXPelota <= posXLadrillo + anchoLadrillo) &&
           (posYPelota >= posYLadrillo && posYPelota <= posYLadrillo + altoLadrillo)){
           velocidadYPelota = -velocidadYPelota;
            //Se oculta el ladrillo
           visibilidadLadrillos[fila*numeroColumnas+columna] = false;
           fila = numeroFilas;
           break;
         }
      }
    }
  }
  //se actualiza la posición de la pelota
  posXPelota = posXPelota + velocidadXPelota;
  posYPelota = posYPelota + velocidadYPelota;
  //Se pinta la pelota
  ellipse(posXPelota,posYPelota,anchoPelota,anchoPelota);
}

void pintaRaqueta(){ 
  posXRaqueta = int(map(posicionMando, 0, 1023, 0, width - anchoRaqueta));
  rect(posXRaqueta, posYRaqueta, anchoRaqueta, altoRaqueta);
}

void pintaLadrillos(){
  for(int fila = 0; fila < numeroFilas; fila++){
    fill(colores[fila]);
    for(int columna = 0; columna < numeroColumnas; columna++){
      //solo se visualizan los ladrillos cuyo valor en el array de visibilidad sea true
      if(visibilidadLadrillos[fila*numeroColumnas+columna]) rect(columna*anchoLadrillo, fila*altoLadrillo+alturaPrimeraFila, anchoLadrillo, altoLadrillo);
    }
  }
  fill(255);
}

void keyPressed(){
  if (key == ' ') nuevoJuego=true; 
}

void serialEvent(Serial puerto) {
  posicionMando = int(trim(puerto.readStringUntil('\n')));
}

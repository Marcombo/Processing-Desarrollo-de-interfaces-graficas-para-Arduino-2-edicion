import processing.serial.*;

Serial puerto; 

int nivelLuz = 127;
int posicionDeslizador;
int radioDeslizador = 50;
boolean deslizadorPulsado = false;

void setup() { 
  size(800, 200);
  
  strokeWeight(4);
  textSize(30);
  textAlign(CENTER, CENTER);
  
  posicionDeslizador = width/2;
  
  puerto = new Serial(this, "COM7", 9600);
}

void draw() {
   if(deslizadorPulsado && 
      mouseX >= radioDeslizador && mouseX <= width - radioDeslizador){
     posicionDeslizador = mouseX;
     nivelLuz = int(map(mouseX, radioDeslizador, width - radioDeslizador, 0, 255));
   }

   puerto.write(nivelLuz);
   
   background(nivelLuz, 0, 0);  
   stroke(255);
   line(0, height/2, width, height/2);
   stroke(255);
   fill(100);
   ellipse(posicionDeslizador, height/2, radioDeslizador*2, radioDeslizador*2);
   fill(255);
   text(nivelLuz, posicionDeslizador, height/2);
}

void mouseReleased(){
  deslizadorPulsado = false;
}

void mousePressed(){
  float distanciaX = posicionDeslizador - mouseX;
  float distanciaY = height/2 - mouseY;
  if(sqrt(sq(distanciaX) + sq(distanciaY)) < radioDeslizador )
    deslizadorPulsado = true;
}

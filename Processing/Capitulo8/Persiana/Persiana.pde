import processing.serial.*;
Serial puerto; 

PImage miImagen; 
int apertura = 0;
int alto_lama = 20;

void setup() 
{
  puerto = new Serial(this, "COM7", 9600);
  size(1000, 600); 
  miImagen = loadImage("Sabero.jpg");
  imageMode(CENTER);
  rectMode(CENTER);
  fill(247, 231, 45);
}

void draw() {
 image(miImagen, width/2, height/2);
 rect(width/2, height/2 - apertura/2, 
      miImagen.width, miImagen.height - apertura);
 for(int y = height/2 + miImagen.height/2; 
     y >  height/2 - miImagen.height/2 + apertura; 
     y = y - alto_lama){
   rect(width/2, y - apertura, miImagen.width, 2);
 }
}

void keyPressed(){
  if (key == CODED){
    switch(keyCode){
      case UP: 
        apertura++;
        puerto.write(0);
        break;
      case DOWN:
        apertura--;
        puerto.write(1);
    }
  }
  if (apertura > miImagen.height) apertura = miImagen.height;
  if (apertura < 0) apertura = 0;
}

void keyReleased(){
  if (key == CODED){
    switch(keyCode){
      case UP: puerto.write(2); break;
      case DOWN: puerto.write(2);
    }
  }
}

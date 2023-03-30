PImage miImagen;

float angulo = 0;
float incremento = 0.1;

void setup() { 
  size(600, 600); 
  miImagen = loadImage("espiral.png");
  imageMode(CENTER);
}

void draw() { 
  background(255);
  translate(width/2, height/2); 
  rotate(angulo);
  image(miImagen, 0, 0);
  angulo += incremento;
}

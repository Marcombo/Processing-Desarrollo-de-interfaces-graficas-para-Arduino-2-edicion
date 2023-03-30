PImage miImagen; 

void setup() { 
  size(800, 600); 
  miImagen = loadImage("cervatillo.jpg");
  imageMode(CENTER);
}

void draw() { 
  image(miImagen, width/2, height/2, miImagen.width/5, miImagen.height/5); 
}

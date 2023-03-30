int ladoCubo = 200;
float rotacionX, rotacionY;

void setup() {
  size(800, 600, P3D);
  stroke(255);
  strokeWeight(2);
  noFill();
}

void draw() {
  background(100);
  
  //Se calculan los ángulos de rotación (en radianes)
  rotacionX = (mouseY/float(width))*-TWO_PI+PI;
  rotacionY = (mouseX/float(height))*TWO_PI-PI;

  // Se centran los ejes de coordenadas en la ventana
  translate(width/2, height/2, 0); 
  //Se rotan
  rotateX(rotacionX);  
  rotateY(rotacionY);  
  
  //Se dibuja el cubo
  box(ladoCubo); 
}

float anguloSegundos, anguloMinutos, anguloHoras;

void setup() {
  size(275, 275);
}

void draw() {
  background(255);

  //llevamos los ejes de coordenanas al centro de la pantalla
  translate(width / 2, height / 2);
  
  // Se dibuja el marco del reloj
  strokeWeight(4);
  stroke(0, 0, 255);
  fill(0, 0, 255);
  ellipse(0, 0, 250, 250);
  fill(255);
  ellipse(0, 0, 200, 200);
  
  stroke(0);
  

  strokeWeight(1);
  // Ángulo que se mueve la aguja del segundero cada segundo
  anguloSegundos = 360 / 60 * second();
  //Se dibuja la aguja del segundero
  pushMatrix();
  rotate(radians(anguloSegundos));
  line(0, 0, 0, -95);
  popMatrix();
  
  // Ángulo que se mueve la aguja del minutero cada minuto
  anguloMinutos = 360 / 60 * minute();
  //Se dibuja la aguja del minutero
  strokeWeight(2);
  pushMatrix();
  rotate(radians(anguloMinutos));
  line(0, 0, 0, -90);
  popMatrix();
  
  // Ángulo que se mueve la aguja que marca las horas cada hora
  anguloHoras = 360 / 12 * hour();
  //Se dibuja la aguja que marca la horas
  strokeWeight(4);
  pushMatrix();
  rotate(radians(anguloHoras));
  line(0, 0, 0, -50);
  popMatrix();
}

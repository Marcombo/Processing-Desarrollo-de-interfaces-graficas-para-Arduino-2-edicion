void setup() { 
  size(450, 255);
  stroke(255);
  background(0);
} 
void draw() { 
  if (mousePressed == true) line(pmouseX, pmouseY, mouseX, mouseY); 
}

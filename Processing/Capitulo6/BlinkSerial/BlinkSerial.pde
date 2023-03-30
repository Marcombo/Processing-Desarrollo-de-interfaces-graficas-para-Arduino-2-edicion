import processing.serial.*;

Serial puerto;

void setup() 
{
  puerto = new Serial(this, Serial.list()[0], 9600);
}
void draw() {
  puerto.write('1');

  delay(1000);
  puerto.write('0');

  delay(1000);
}

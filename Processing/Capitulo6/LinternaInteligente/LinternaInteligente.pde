import processing.serial.*;
import cc.arduino.*;

Arduino miArduino;
int fotocelulaPin = 0;
int nivelLuzArduino, nivelLuzPantalla;

void setup()
{
  fullScreen();
  miArduino = new Arduino(this, Arduino.list()[0], 57600);
  miArduino.pinMode(fotocelulaPin, Arduino.INPUT);
}

void draw()
{
  nivelLuzArduino = miArduino.analogRead(fotocelulaPin);
  nivelLuzPantalla = int(map(nivelLuzArduino, 0, 1023, 255, 0));
  background(nivelLuzPantalla);
}

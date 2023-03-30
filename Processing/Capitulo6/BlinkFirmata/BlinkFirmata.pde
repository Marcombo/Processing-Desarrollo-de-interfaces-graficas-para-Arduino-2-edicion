import processing.serial.*;
import cc.arduino.*;

Arduino miArduino;
int ledPin = 13;

void setup()
{
  miArduino = new Arduino(this, Arduino.list()[0], 57600);
  miArduino.pinMode(ledPin, Arduino.OUTPUT);
}

void draw()
{
  miArduino.digitalWrite(ledPin, Arduino.HIGH);
  delay(1000);
  miArduino.digitalWrite(ledPin, Arduino.LOW);
  delay(1000);
}

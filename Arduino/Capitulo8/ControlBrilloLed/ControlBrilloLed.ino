#include <SoftwareSerial.h> 
SoftwareSerial puertoHC05(2, 3); //2(RX) / 3(TX)

int nivel; 
int ledPin = 5; 

void setup() 
{
  pinMode(ledPin, OUTPUT); 
  puertoHC05.begin(9600);
}

void loop()
{
  if (puertoHC05.available() > 0) { 
    nivel = puertoHC05.read();
    analogWrite(ledPin, nivel);
    delay(10);
  }
}


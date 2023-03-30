#include <SoftwareSerial.h> 
SoftwareSerial puertoHC05(2, 3); //2(RX) / 3(TX)

int pinRele = 4;

void setup() {
  pinMode(pinRele, OUTPUT); 
  puertoHC05.begin(9600);
}

void loop(){
  if (puertoHC05.available() > 0) { 
    if (puertoHC05.read()) digitalWrite(pinRele, true);
    else digitalWrite(pinRele, false);
  }
}


#include <SoftwareSerial.h> 
SoftwareSerial puertoHC05(2, 3); //2(RX) / 3(TX)

int pinSube = 4;
int pinBaja = 5;

void setup() {
  pinMode(pinSube, OUTPUT); 
  pinMode(pinBaja, OUTPUT); 
  puertoHC05.begin(9600);
}

void loop(){
  if (puertoHC05.available() > 0) { 
    switch (puertoHC05.read()){
      case 0: digitalWrite(pinSube, true); break;
      case 1: digitalWrite(pinBaja, true); break;
      case 2: digitalWrite(pinSube, false); digitalWrite(pinBaja, false); break;
    }
  }
}


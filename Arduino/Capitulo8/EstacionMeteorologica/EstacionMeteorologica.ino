#include <SimpleDHT.h>
#include <SoftwareSerial.h>

SoftwareSerial puertoHC05(2, 3); // RX | TX

int pinDHT11 = 4;
SimpleDHT11 dht11;

byte temperatura = 0;
byte humedad = 0;
 
void setup() {
   puertoHC05.begin(9600);
}
 
void loop() {
  dht11.read(pinDHT11, &temperatura, &humedad, NULL);
  if (!isnan(temperatura) && !isnan(humedad)) puertoHC05.println(String(temperatura)+","+String(humedad));
  delay(1000);
}

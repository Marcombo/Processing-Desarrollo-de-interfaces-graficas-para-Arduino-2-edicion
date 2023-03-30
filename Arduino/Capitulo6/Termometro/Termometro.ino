#include <SimpleDHT.h>

SimpleDHT11 dht11;
int pinDHT11 = 2;
byte temperatura, humedad = 0;
 
void setup() {
   Serial.begin(9600);
}
 
void loop() {
  dht11.read(pinDHT11, &temperatura, &humedad, NULL);
  if (!isnan(temperatura)) Serial.write(temperatura);
  delay(1000);
}

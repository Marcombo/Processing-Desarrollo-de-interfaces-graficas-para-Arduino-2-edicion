int PinJoyStick = A1;
int posicion;
 
void setup() {
  Serial.begin(115200);
}
 
void loop() {
   posicion = analogRead(PinJoyStick);
   Serial.println(posicion);
   delay(10);
}

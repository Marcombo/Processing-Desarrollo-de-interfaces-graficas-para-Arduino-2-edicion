const int analogPin = A0;
 
void setup() {
  Serial.begin(115200); 
}
 
void loop() {
  int val = analogRead(analogPin);
  Serial.println(val);
}

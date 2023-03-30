#include <Servo.h>

Servo servo;
int angulo;
int pinServo = 3; 

void setup() {
  Serial.begin(115200);

  servo.attach(pinServo);
  servo.write(0);
}

void loop(){
  if (Serial.available() > 0) { 
    angulo = Serial.read();
    servo.write(angulo);
    delay(20);
  }
}
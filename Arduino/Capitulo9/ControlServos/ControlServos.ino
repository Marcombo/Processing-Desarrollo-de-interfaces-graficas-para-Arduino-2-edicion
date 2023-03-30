//Processing envía: "SERVO_X=<angulo>", "SERVO_Y=<angulo>"

#include <Servo.h>

Servo servoX, servoY;
int pinServoX =3, pinServoY = 11; 

char c;
String input;
String comando;
String valor;

void setup() {
  Serial.begin(115200);
  
  servoX.attach(pinServoX);
  servoY.attach(pinServoY); 

  // lleva el servo a posición inicial
  servoX.write(90);
  servoY.write(90);
}

void loop(){
  //lee la entrada
  input = "";
  if (Serial.available()){
    delay(20);
    while(Serial.available()){
      c = Serial.read();
      if (c == '\n') break;
      else input += c;
    }

    comando = input.substring(0, input.indexOf("="));  // identifica el comando
    valor = input.substring(input.indexOf("=")+1);  // identifica el valor    
    if (comando == "SERVO_X") servoX.write(valor.toInt());
    if (comando == "SERVO_Y") servoY.write(valor.toInt()); 
    }
}

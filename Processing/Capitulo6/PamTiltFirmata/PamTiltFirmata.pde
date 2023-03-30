import processing.serial.*;
import cc.arduino.*;

Arduino miArduino;

int servoX = 3;
int servoZ = 11;
int anguloX, anguloZ;

void setup()
{
  size(400,400,P3D);
  rectMode(CENTER); 
  miArduino = new Arduino(this, Arduino.list()[0], 57600);
  miArduino.pinMode(servoX, Arduino.SERVO);
  miArduino.pinMode(servoZ, Arduino.SERVO);
}

void draw()
{
  background(125);
  translate(width/2, height/2,0);
  anguloX = int(map(mouseY, 0, height, 180, 0));
  anguloZ = int(map(mouseX, 0, width, 180, 0));
  rotateX(radians(anguloX));
  rotateZ(-radians(anguloZ));
  rect(0,0,100,200);
  miArduino.servoWrite(servoX, anguloX);
  miArduino.servoWrite(servoZ, anguloZ);
  
}

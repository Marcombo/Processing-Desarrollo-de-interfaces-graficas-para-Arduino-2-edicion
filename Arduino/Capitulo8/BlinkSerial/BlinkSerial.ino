char datoRecibido; 
int ledPin = 13; 

void setup() 
{
  pinMode(ledPin, OUTPUT); 
  Serial.begin(9600);
}

void loop()
{
  if (Serial.available() > 0) { 
    datoRecibido = Serial.read(); 
    switch (datoRecibido){
      case '0': digitalWrite(ledPin, LOW); break;
      case '1': digitalWrite(ledPin, HIGH); break;
    }
    delay(10);
  }
}


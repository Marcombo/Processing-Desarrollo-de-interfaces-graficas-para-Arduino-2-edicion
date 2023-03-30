#include <ESP8266WiFi.h>
#include <PubSubClient.h>

const char* ssid = "MOVISTAR_C928";             // SSID de la red WIFI a la que desea conectarse
const char* password = "J9AEPNkVHTVHRgYFdkdd";  // contraseña de dicha red

const char* mqtt_server = "test.mosquitto.org"; //broker
const char* id = "wemos_processing";  // Usuario de conexión al broker (elija cualquier otro diferente)
const char* tema = "wemos_luz_cocina"; //tema al que se suscribe
const char* tema_confirmacion = "wemos_luz_cocina_confirmacion"; //tema en el que se publican las confirmación de las órdenes

WiFiClient clienteWIFI;
PubSubClient clienteMQTT(clienteWIFI);

int pinRele = 13; 

void setup() {
  pinMode(pinRele, OUTPUT);
  digitalWrite(pinRele, LOW);
  
  Serial.begin(115200);

  //Inicializa la conexión WIFI
  Serial.print("Conectando a " + String(ssid) + " ");     
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println(" Conectado");

  //Establecerá el broker que utilizará
  clienteMQTT.setServer(mqtt_server, 1883);
  //Establecerá la función a la que va a llamar cuando llegue un mensaje del broker
  clienteMQTT.setCallback(callback);
}

void callback(char* tema, byte* contenido, unsigned int longitudContenido) {
  String mensaje = "";
  Serial.print("Ha llegado un mensaje con el tema: ");
  Serial.print(tema);
  Serial.print(" y el contenido: ");
  for (int i = 0; i < longitudContenido; i++) {
    mensaje = mensaje + (char)contenido[i];
  }
  Serial.println(mensaje);
  //Activa o desactiva el rele
  if (mensaje == "ON"){
    digitalWrite(pinRele, HIGH);
    clienteMQTT.publish(tema_confirmacion, "ON");
  }
  else if (mensaje == "OFF"){
    digitalWrite(pinRele, LOW); 
    clienteMQTT.publish(tema_confirmacion, "OFF");
  }
}

void loop() {
  //Establecerá la conexión con el broker 
  while (!clienteMQTT.connected()) {
      Serial.print("Conectando al broker ...");
      if (clienteMQTT.connect(id)) {
        Serial.println("Conectado al broker.");
        clienteMQTT.subscribe(tema);
      } else {
        delay(5000);
      }
  }
  // Cliente escuchando
  clienteMQTT.loop();
}

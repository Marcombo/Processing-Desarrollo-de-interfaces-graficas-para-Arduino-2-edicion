#include <SimpleDHT.h>
#include <ESP8266WiFi.h>
#include <PubSubClient.h>

const char* ssid = "MOVISTAR_C928";             // SSID de la red WIFI a la que desea conectarse
const char* password = "J9AEPNkVHTVHRgYFdkdd";  // contraseña de dicha red

const char* mqtt_server = "test.mosquitto.org";
const char* id = "marcombo_wemos";
const char* tema_dht11 = "iot_mqtt_panel_dht11";
const char* tema_rele = "iot_mqtt_panel_rele";
const char* tema_led = "iot_mqtt_panel_led";

WiFiClient clienteWIFI;
PubSubClient clienteMQTT(clienteWIFI);

int pinRele = 13;
int pinDHT11 = 12;
SimpleDHT11 dht11;
byte temperatura = 0;
byte humedad = 0;

unsigned int tiempoAnterior;
int intervaloEnviotemperatura = 2000;

void setup() {
  pinMode(pinRele, OUTPUT);
  digitalWrite(pinRele, LOW);
  pinMode(pinDHT11, INPUT);
  
  Serial.begin(115200);

  //Se inicializa la conexión WiFI
  Serial.print("Conectando a " + String(ssid) + " ");     
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println(" Conectado");

  //Se especifica el broker que se utilizará
  clienteMQTT.setServer(mqtt_server, 1883);
  //Se determina la función a la que se va a llamar cuando llegue un mensaje del broker
  clienteMQTT.setCallback(callback);
}

void callback(char* tema_recibido, byte* contenido, unsigned int longitudContenido) {
  String mensaje = "";
  Serial.print("Ha llegado un mensaje con el tema: ");
  Serial.print(tema_recibido);
  Serial.print(" y el contenido: ");
  for (int i = 0; i < longitudContenido; i++) {
    mensaje = mensaje + (char)contenido[i];
  }
  Serial.println(mensaje);
  //Se activa o desactiva el rele
  if (mensaje == "ON"){
    digitalWrite(pinRele, HIGH);
    clienteMQTT.publish(tema_led, "ON");
  }
  else if (mensaje == "OFF"){
    digitalWrite(pinRele, LOW);
    clienteMQTT.publish(tema_led, "OFF");
  }
}

void loop() {
  //Se establece la conexión con el broker 
  while (!clienteMQTT.connected()) {
      Serial.print("Conectando al broker ...");
      if (clienteMQTT.connect(id)) {
        Serial.println("Conectado al broker.");
        clienteMQTT.subscribe(tema_rele);
      } else delay(5000);
  }
  if(millis() - tiempoAnterior > intervaloEnviotemperatura){
    dht11.read(pinDHT11, &temperatura, &humedad, NULL);
    if (!isnan(temperatura)){
      Serial.print((int)temperatura); Serial.println(" ºC, ");
      char tmp[4];
      dtostrf((int)temperatura,0, 0, tmp);
      clienteMQTT.publish(tema_dht11, tmp);
    }
    tiempoAnterior = millis();
  }
  // Cliente escuchando
  clienteMQTT.loop();
}

import mqtt.*;

MQTTClient cliente;
String broker = "tcp://test.mosquitto.org";
String id = "processing_wemos";
String temaLuzCocina = "wemos_luz_cocina";
String temaLuzCocinaConfirmacion = "wemos_luz_cocina_confirmacion";
String temaLuzSalon = "wemos_luz_salon";
String temaLuzSalonConfirmacion = "wemos_luz_salon_confirmacion";

boolean estadoLuzCocina = false;
boolean estadoLuzSalon = false;

PImage planoCasa, luz_on, luz_off; 
int[] posicionLuzCocina = {150, 75};
int[] posicionLuzSalon = {635, 275};
int lado;

void setup() {
  size(800, 400);
  
  planoCasa = loadImage("plano_casa.png");
  luz_on = loadImage("luz_on.png");
  luz_off = loadImage("luz_off.png");
  lado = luz_on.width;
  
  cliente = new MQTTClient(this);
  cliente.connect(broker, id);
  cliente.subscribe(temaLuzCocinaConfirmacion);
  cliente.subscribe(temaLuzSalonConfirmacion);
  cliente.publish(temaLuzCocina, "OFF");
  cliente.publish(temaLuzSalon, "OFF");
}

void draw() {
  image(planoCasa, 0, 0);
  if (estadoLuzCocina)
    image(luz_on, posicionLuzCocina[0], posicionLuzCocina[1]);
  else
    image(luz_off, posicionLuzCocina[0], posicionLuzCocina[1]);
  if (estadoLuzSalon)
    image(luz_on, posicionLuzSalon[0], posicionLuzSalon[1]);
  else
    image(luz_off, posicionLuzSalon[0], posicionLuzSalon[1]);
}

void clientConnected() {
  println("Cliente conectado");
}

void messageReceived(String topic, byte[] payload) {
  String mensaje = new String(payload);
  if(topic.equals(temaLuzCocinaConfirmacion))
    if (mensaje.equals("ON"))
      estadoLuzCocina = true;
    else if (mensaje.equals("OFF"))
      estadoLuzCocina = false;
  if(topic.equals(temaLuzSalonConfirmacion))
    if (mensaje.equals("ON"))
      estadoLuzSalon = true;
    else if (mensaje.equals("OFF"))
      estadoLuzSalon = false;
}

void connectionLost() {
  println("Conexión perdida");
}

void mousePressed() {
  if(luzPulsada(posicionLuzCocina))
    if(estadoLuzCocina){
      cliente.publish(temaLuzCocina, "OFF");
    }
    else{
      cliente.publish(temaLuzCocina, "ON");
    }
  if(luzPulsada(posicionLuzSalon))
    if(estadoLuzSalon){
      cliente.publish(temaLuzSalon, "OFF");
    }
    else{
      cliente.publish(temaLuzSalon, "ON");
    }
}

boolean luzPulsada(int[] esquina) {
  if( mouseX > esquina[0] && mouseX < esquina[0] + lado &&
      mouseY > esquina[1] && mouseY < esquina[1] + lado)
    return true;
  else
    return false;
}

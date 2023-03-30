import processing.video.*;

Capture camara;

void setup() {
  size(640, 480);
  camara = new Capture(this, 640, 480);
  camara.start();
}

void draw() {
  image(camara, 0, 0 );
}

void mouseClicked(){
  saveFrame("foto.png");
}

void captureEvent(Capture camara) {
  camara.read();
}

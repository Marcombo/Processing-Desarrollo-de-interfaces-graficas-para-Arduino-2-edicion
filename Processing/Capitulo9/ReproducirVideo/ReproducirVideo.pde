import processing.video.*; 

Movie pelicula; 
boolean estadoReproduccion= true;

void setup() {  
  size(1920,1080);

  pelicula = new Movie(this, "Madrid.mov");  
  pelicula.play();
}

void draw() {
  image(pelicula, 0, 0);
}

void movieEvent(Movie pelicula) {  
  pelicula.read();
}

void mouseClicked(){
  if(estadoReproduccion) pelicula.pause();
  else pelicula.play();
  estadoReproduccion = !estadoReproduccion;
}

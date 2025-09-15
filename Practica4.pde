PImage foto1;

void setup() {
  size(1091, 768);
  background(0);
  foto1 = loadImage("Green.jpg");
}

void draw() {
  background(0); // Limpiar el fondo

  // Calcular factores de escala para ancho y alto
  float escalaX = (float) width / foto1.width;
  float escalaY = (float) height / foto1.height;

  // Elegir el menor para mantener proporciones
  float escala = min(escalaX, escalaY);

  // Calcular posición para centrar la imagen
  float x = (width - foto1.width * escala) / 2;
  float y = (height - foto1.height * escala) / 2;

  // Dibujar la imagen escalada y centrada
  image(foto1, x, y, foto1.width * escala, foto1.height * escala);
}

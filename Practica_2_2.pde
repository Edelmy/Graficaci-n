//Reescribir el código de la práctica 1-1 de forma que se utilice una forma libre (shape) para el dibujo del polígono de n lados
//Chay Edelmy
// Desarrollar un programa en Processing que dibuje polígonos de n lados
// usando beginShape() y vertex() para una forma libre
// Chay Edelmy

void setup() {
  size(500, 500);
  background(0, 200, 0); // fondo verde
  stroke(0);             // color de línea negro
  fill(255, 150, 0);     // relleno naranja
  poligono(250, 250, 100, 6); // ejemplo: hexágono centrado
}

void poligono(int centroX, int centroY, int radio, int numLados) {
  beginShape();
  for (int i = 0; i < numLados; i++) {
    float angulo = i * TWO_PI / numLados; // ángulo en radianes
    float x = centroX + cos(angulo) * radio;
    float y = centroY + sin(angulo) * radio;
    vertex(x, y);
  }
  endShape(CLOSE); // cierra el polígono automáticamente
}

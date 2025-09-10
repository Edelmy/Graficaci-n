/*En una aplicación estadística se necesita representar un
gráfico de tarta capaz de visualizar un conjunto de
elementos porcentuales
• Los elementos vienen como un vector y la suma de todos
ellos totaliza el 100%*/

//Chay Edelmy
// Gráfico de tarta básico en Processing
float[] valores = {25.0, 45.0, 5.0, 15.0, 10.0};

void setup() {
  size(500, 500);
  background(255);
  // Implementar una función que a partir de este vector, dibuje un gráfico de tarta que represente gráficamente estos porcentajes
  tarta(250, 250, 150, valores);
}

void tarta(float centroX, float centroY, float radio, float[] datos) {
  float anguloInicio = 0; // inicia en 0 grados
  for (int i = 0; i < datos.length; i++) {
    // Calcula el ángulo del segmento en radianes
    float anguloSegmento = datos[i] / 100.0 * TWO_PI;
    // Color aleatorio para el segmento
    fill(random(255), random(255), random(255));
    noStroke();
    // Dibuja el arco correspondiente al segmento
    arc(centroX, centroY, radio*2, radio*2, anguloInicio, anguloInicio + anguloSegmento);
    // Actualiza el ángulo de inicio para el siguiente segmento
    anguloInicio += anguloSegmento;
  }
}

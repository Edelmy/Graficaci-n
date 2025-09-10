// Gráfico de barras 2D básico
//desarrollar una función análoga a la práctica 2-3 pero esta vez con el objetivo de dibujar un gráfico de barras 2D. 
//Chay Edelmy
float[] valores = {25.0, 45.0, 5.0, 15.0, 10.0};

void setup() {
  size(500, 500);
  background(255);
  Barras(valores);
}

void Barras(float[] datos) {
  float anchoBarra = width / datos.length; // ancho de cada barra según número de valores
  float escalaAltura = height / 100.0;    // escala para que 100% ocupe toda la ventana

  // Dibujar ejes
  stroke(0);
  line(0, height, width, height); // eje X
  line(0, 0, 0, height);          // eje Y

  // Dibujar barras  
  for (int i = 0; i < datos.length; i++) {
    float barraAltura = datos[i] * escalaAltura;
    fill(random(255), random(255), random(255)); // color aleatorio
    noStroke();
    rect(i * anchoBarra, height - barraAltura, anchoBarra, barraAltura); // dibuja la barra
  }
}

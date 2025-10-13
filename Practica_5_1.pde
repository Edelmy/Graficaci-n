 //Chay Edelmy
 int n = 20;               // Número de bolas (cámbialo para n diferente)
 int diametro = 30;        // Diámetro de cada bola
 int[] px, py, vx, vy;     // Arreglos de posición y velocidad

void setup() {
  size(600, 300);         // Tamaño de ventana
  fill(255);
  noStroke();
  
  // Inicializar arreglos
  px = new int[n];
  py = new int[n];
  vx = new int[n];
  vy = new int[n];
  
  // Posiciones y velocidades aleatorias
  for (int i = 0; i < n; i++) {
    px[i] = (int) random(diametro/2, width - diametro/2);
    py[i] = (int) random(diametro/2, height - diametro/2);
    int magnitudX = (int) random(1, 5);                 // 1..4
    vx[i] = magnitudX * (random(1) > 0.5 ? 1 : -1);
    int magnitudY = (int) random(1, 5);                 // 1..4 (¡corregido!)
    vy[i] = magnitudY * (random(1) > 0.5 ? 1 : -1);
  }
  
  // frameRate(12);  // Descomenta para ralentizar (como en tu código original)
}

  void draw() {
    fill(0, 20);                 // Fondo semitransparente (estelas)
    rect(0, 0, width, height);
    fill(255);
  
  for (int i = 0; i < n; i++) {
    // Rebote en X (verificar antes de mover)
    if (px[i] + diametro/2 > width || px[i] - diametro/2 < 0) {
      vx[i] *= -1;
    }
    // Rebote en Y (verificar antes de mover)
    if (py[i] + diametro/2 > height || py[i] - diametro/2 < 0) {
      vy[i] *= -1;
    }
    // Mover
    px[i] += vx[i];
    py[i] += vy[i];
    // Dibujar
    ellipse(px[i], py[i], diametro, diametro);
  }
}

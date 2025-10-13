//Chay Edelmy
float rotX = 0.0, rotY = 0.0;
int lastX, lastY;
float distX = 0.0, distY = 0.0;

// Pasos de función
int steps = 50; 
// Escala de la superficie 
float scaleZ = 0.7;
float zOffset = 100.0;  // Desplazamiento en Z para zoom
float gX = 1.0, gY = 1.0; 

void setup() {
  size(500, 500, P3D); // Usa P3D para 3D
  noFill();  // Superficie wireframe (líneas, no rellena) 
}

float funcion(float x, float y) {
  return x*x + y*y;
}

void draw() {
  background(0);
  lights();  // Iluminación para resaltar la elevación 3D 
  
  // Centrar y aplicar zoom 
  translate(width/2, height/2, zOffset);
  // Rotaciones según ratón
  rotateY(rotY + distX);
  rotateX(rotX + distY);

  // Dibujar superficie
  stroke(255);  // Color blanco para la malla 
  dibujarFuncion();

  // Dibujar ejes
  strokeWeight(2);
  stroke(255, 0, 0);  // Rojo para X
  line(0, 0, 0, 120, 0, 0); // Eje X
  stroke(0, 255, 0);  // Verde para Y
  line(0, 0, 0, 0, 120, 0); // Eje Y
  stroke(0, 0, 255);  // Azul para Z
  line(0, 0, 0, 0, 0, 120); // Eje Z
  strokeWeight(1);  
}

void dibujarFuncion() {
  float x, y;
  int i, j;
  float in_steps = gX / steps;
  float[][] matriz = new float[steps+1][steps+1];

  // Llenar matriz con valores de la función
  for (j = 0, y = -gY/2; j <= steps; j++, y += in_steps) {
    for (i = 0, x = -gX/2; i <= steps; i++, x += in_steps) {
      matriz[i][j] = funcion(x, y);
    }
  }

  // Dibujar superficie como malla de QUAD_STRIP 
  for (j = 0, y = -gY/2; j < steps; j++, y += in_steps) {
    beginShape(QUAD_STRIP);
    for (i = 0, x = -gX/2; i <= steps; i++, x += in_steps) {
      vertex(x * 100, y * 100, matriz[i][j] * 100 * scaleZ);
      vertex(x * 100, (y + in_steps) * 100, matriz[i][j + 1] * 100 * scaleZ);
    }
    endShape();
  }
}

void mousePressed() {
  lastX = mouseX;
  lastY = mouseY;
}

void mouseDragged() {
  distX = radians(mouseX - lastX);
  distY = radians(mouseY - lastY);  // Movimiento intuitivo en Y
}

void mouseReleased() {
  rotX += distY;
  rotY += distX; 
  distX = distY = 0.0;
}

// Control de zoom con teclas UP y DOWN 
void keyPressed() {
  if (key == CODED) {  // Para teclas direccionales
    if (keyCode == UP) {
      // Acercamiento 
      zOffset = min(zOffset + 10, 500);  // Más cerca
    } else if (keyCode == DOWN) {
      // Alejamiento 
      zOffset = max(zOffset - 10, -500);  // Más lejos
    }
  }
}

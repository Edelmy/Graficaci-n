//Chay Edelmy
//Modificar el programa anterior para dibujar la superficie mediante un gradiente de dos colores (por ejemplo, rojo valores bajos de z, amarillos valores altos)
//Usar para ello un fill() previo a cada vertex()
float rotX = 0.0, rotY = 0.0;
int lastX, lastY;
float distX = 0.0, distY = 0.0;

int steps = 50; 
// Escala 
float scaleZ = 0.7;
float zOffset = 100.0;  
float gX = 1.0, gY = 1.0; 

void setup() {
  size(500, 500, P3D); 
}

float funcion(float x, float y) {
  return x*x + y*y;
}

void draw() {
  background(0);
  lights();  
  
  translate(width/2, height/2, zOffset);
  rotateY(rotY + distX);
  rotateX(rotX + distY);

  stroke(255); 
  dibujarFuncion();

  // Dibuja ejes
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

  float minZ = Float.MAX_VALUE;
  float maxZ = Float.MIN_VALUE;
  for (j = 0, y = -gY/2; j <= steps; j++, y += in_steps) {
    for (i = 0, x = -gX/2; i <= steps; i++, x += in_steps) {
      float z = funcion(x, y);
      matriz[i][j] = z;
      if (z < minZ) minZ = z;
      if (z > maxZ) maxZ = z;
    }
  }

  // Dibuja la superficie como cuadriláteros individuales
  noStroke();
  for (j = 0, y = -gY/2; j < steps; j++, y += in_steps) {
    for (i = 0, x = -gX/2; i < steps; i++, x += in_steps) {
      float z1 = matriz[i][j];
      float z2 = matriz[i+1][j];
      float z3 = matriz[i+1][j+1];
      float z4 = matriz[i][j+1];
      float avgZ = (z1 + z2 + z3 + z4) / 4.0;
      float norm = map(avgZ, minZ, maxZ, 0, 1);
      fill(lerpColor(color(255,0,0), color(255,255,0), norm)); // rojo a amarillo

      beginShape(QUADS);
      vertex(x * 100, y * 100, z1 * 100 * scaleZ);
      vertex((x + in_steps) * 100, y * 100, z2 * 100 * scaleZ);
      vertex((x + in_steps) * 100, (y + in_steps) * 100, z3 * 100 * scaleZ);
      vertex(x * 100, (y + in_steps) * 100, z4 * 100 * scaleZ);
      endShape();
    }
  }
}


void mousePressed() {
  lastX = mouseX;
  lastY = mouseY;
}

void mouseDragged() {
  distX = radians(mouseX - lastX);
  distY = radians(mouseY - lastY);  
}

void mouseReleased() {
  rotX += distY;
  rotY += distX; 
  distX = distY = 0.0;
}

// Control de zoom con  UP y DOWN 
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

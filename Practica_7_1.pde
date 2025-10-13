// Cubo interactivo con imagen y zoom en Z
//Chay Edelmy
float rotX = 0.0, rotY = 0.0;
int lastX, lastY;
float distX = 0.0, distY = 0.0;
float zOffset = 0.0;  // Desplazamiento en Z para zoom (inicial 0, rango 0 a -500)

PImage tex;  // Imagen para la textura

void setup() {
  size(400, 400, P3D);
  tex = loadImage("Green.jpg");  
  noStroke();
  textureMode(NORMAL);  // Mapeo UV de 0 a 1 para la textura
}

void draw() {
  background(0);
  lights();  // Iluminación

  translate(width/2, height/2);  // Centrar en la pantalla
  translate(0, 0, zOffset);      // Zoom en Z (0 = cerca, -500 = lejos)
  rotateX(rotX + distY);         // Rotación en X (con mouse)
  rotateY(rotY + distX);         // Rotación en Y (con mouse)
  
  // Dibuja cubo texturizado 
  float tam = 100;  // Mitad del tamaño del cubo
  texture(tex);     // Aplicar la textura a todas las caras
  
  // Cara frontal
  beginShape(QUADS);
  texture(tex);
  vertex(-tam, -tam,  tam, 0, 0);
  vertex( tam, -tam,  tam, 1, 0);
  vertex( tam,  tam,  tam, 1, 1);
  vertex(-tam,  tam,  tam, 0, 1);
  endShape();
  
  // Cara trasera 
  beginShape(QUADS);
  texture(tex);
  vertex(-tam, -tam, -tam, 0, 0);
  vertex(-tam,  tam, -tam, 0, 1);
  vertex( tam,  tam, -tam, 1, 1);
  vertex( tam, -tam, -tam, 1, 0);
  endShape();
  
  // Cara superior 
  beginShape(QUADS);
  texture(tex);
  vertex(-tam,  tam, -tam, 0, 0);
  vertex(-tam,  tam,  tam, 0, 1);
  vertex( tam,  tam,  tam, 1, 1);
  vertex( tam,  tam, -tam, 1, 0);
  endShape();
  
  // Cara inferior 
  beginShape(QUADS);
  texture(tex);
  vertex(-tam, -tam, -tam, 0, 1);
  vertex( tam, -tam, -tam, 1, 1);
  vertex( tam, -tam,  tam, 1, 0);
  vertex(-tam, -tam,  tam, 0, 0);
  endShape();
  
  // Cara derecha 
  beginShape(QUADS);
  texture(tex);
  vertex( tam, -tam, -tam, 0, 0);
  vertex( tam, -tam,  tam, 1, 0);
  vertex( tam,  tam,  tam, 1, 1);
  vertex( tam,  tam, -tam, 0, 1);
  endShape();
  
  // Cara izquierda
  beginShape(QUADS);
  texture(tex);
  vertex(-tam, -tam, -tam, 1, 0);
  vertex(-tam,  tam, -tam, 1, 1);
  vertex(-tam,  tam,  tam, 0, 1);
  vertex(-tam, -tam,  tam, 0, 0);
  endShape();
}

void mousePressed() {
  lastX = mouseX;
  lastY = mouseY;
}

void mouseDragged() {
  distX = radians(mouseX - lastX);
  distY = radians(lastY - mouseY);
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
      zOffset = max(zOffset + 10, 0);  // No exceder 0
    } else if (keyCode == DOWN) {
      // Alejamiento 
      zOffset = min(zOffset - 10, -500);  // No ir más allá de -500
    }
  }
}

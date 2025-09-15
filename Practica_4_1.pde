/*Modificar la práctica 2-1 de visualización de funciones trigonométricas de forma que se realice un cambio de sistemas de coordenadas de [0, 2*PI] a [0,
width] y de [-1, +1] a [height, 0], mediante la definición de la correspondiente matriz modelo/vista
Chay Edelmy
*/
void setup() {
  size(600, 400);
  
}

void draw() {
  background(255);

  // Trasladar el origen al borde inferior izquierdo
  translate(0, height / 2.0);  // Eje X al centro vertical
  
  // Escalar: ancho completo para 2π y altura para [-1,1] 
  float escalaX = width / TWO_PI;
  float escalaY = height / 2.2;  // Usa casi toda la altura
  scale(escalaX, -escalaY);      // Invertir Y para que +1 sea arriba
  
  // Ejes
  stroke(0);
  strokeWeight(1.0 / escalaX); // Ajusta grosor para que sea visible tras el escalado
  line(0, 0, TWO_PI, 0); // Eje X
  line(0, -1, 0, 1);     // Eje Y

  // Seno
  stroke(255, 0, 0);
  noFill();
  beginShape();
  for (float ang = 0; ang <= TWO_PI; ang += 0.01) {
    vertex(ang, sin(ang));
  }
  endShape();

  // Coseno
  stroke(0, 0, 255);
  noFill();
  beginShape();
  for (float ang = 0; ang <= TWO_PI; ang += 0.01) {
    vertex(ang, cos(ang));
  }
  endShape();
}

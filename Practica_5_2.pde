// Un sistema planetario 
// Un sol, 3 planetas y dos lunas 
// Modificado para dibujar las órbitas de planetas y lunas

float angPlaneta1 = 0.0,
      angPlaneta2 = PI/3.0,
      angPlaneta3 = 2.0*PI/3.0,
      angLuna1 = 0.0,
      angLuna2 = PI;

void setup() {
  size(400, 400);
  stroke(255);
  strokeWeight(1);  // Grosor de línea para órbitas
  frameRate(30);
}

void draw() {
  background(0);

  // Se dibuja todo centrado en el (0,0) y resolvemos
  // sus posiciones finales con transformaciones 2D

  // El sol en el centro de nuestro universo
  translate(width/2, height/2);

  // Sol
  fill(#F1FA03); // Hex. mediante color selector
  noStroke();  // Sin borde para el sol
  ellipse(0, 0, 20, 20);

  // --- Órbita del Planeta 1 ---
  stroke(255);  // Color de órbita (blanco)
  noFill();     // No rellenar la órbita
  float radioPlaneta1 = width / 8.0;  // width/2 / 4 = 50 (corregido para claridad)
  ellipse(0, 0, 2 * radioPlaneta1, 2 * radioPlaneta1);

  pushMatrix();
  // Planeta 1
  rotate(angPlaneta1 += 0.1);
  translate(radioPlaneta1, 0);
  fill(#05FA03);
  noStroke();
  ellipse(0, 0, 15, 15);
  popMatrix();

  // --- Órbita del Planeta 2 ---
  stroke(255);
  noFill();
  float radioPlaneta2 = width / 4.0;  // width/2 / 2 = 100
  ellipse(0, 0, 2 * radioPlaneta2, 2 * radioPlaneta2);

  pushMatrix();
  // Planeta 2
  rotate(angPlaneta2 += 0.05);
  translate(radioPlaneta2, 0);
  fill(#0BA00A);
  noStroke();
  ellipse(0, 0, 15, 15);

  // --- Órbitas de las Lunas (relativas al Planeta 2) ---
  stroke(128);  // Color más tenue para órbitas de lunas (gris)
  noFill();

  // Órbita Luna 1
  float radioLuna1 = radioPlaneta2 / 3.0;  // ~33.33
  ellipse(0, 0, 2 * radioLuna1, 2 * radioLuna1);

  pushMatrix();
  // Luna 1
  rotate(angLuna1 += 0.1);
  translate(radioLuna1, 0);
  fill(#08E4FF);
  noStroke();
  ellipse(0, 0, 6, 6);
  popMatrix();

  // Órbita Luna 2
  float radioLuna2 = radioPlaneta2 * 2.0 / 3.0;  // ~66.67
  ellipse(0, 0, 2 * radioLuna2, 2 * radioLuna2);

  pushMatrix();
  // Luna 2
  rotate(angLuna2 += 0.05);
  translate(radioLuna2, 0);
  fill(#118998);
  noStroke();
  ellipse(0, 0, 6, 6);
  popMatrix();

  popMatrix();  // Fin del contexto del Planeta 2 y sus lunas

  // --- Órbita del Planeta 3 ---
  stroke(255);
  noFill();
  float radioPlaneta3 = width * 3.0 / 8.0;  // width/2 / (4/3) ≈ 150
  ellipse(0, 0, 2 * radioPlaneta3, 2 * radioPlaneta3);

  pushMatrix();
  // Planeta 3
  rotate(angPlaneta3 += 0.025);
  translate(radioPlaneta3, 0);
  fill(#075806);
  noStroke();
  ellipse(0, 0, 15, 15);
  popMatrix();
}

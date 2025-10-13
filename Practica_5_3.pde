
// Sistema planetario con Sol orbitando y planetas con lunas

float angSol = 0.0,
      angPlaneta1 = 0.0,
      angPlaneta2 = PI/3.0,
      angPlaneta3 = 2*PI/3.0,
      angLuna1 = 0.0,
      angLuna2 = PI;

float radioSol = 30;  // Radio de la órbita del Sol alrededor del centro

void setup() {
  size(400, 400);
  frameRate(30);
  noStroke();
}

void draw() {
  background(0);

  translate(width/2, height/2); // Centro de la ventana

  // --- Órbita del Sol ---
  stroke(255, 255, 0);
  noFill();
  ellipse(0, 0, 2*radioSol, 2*radioSol);

  // --- Sol orbitando ---
  pushMatrix();
  rotate(angSol += 0.01);
  translate(radioSol, 0);
  fill(241, 250, 3);
  noStroke();
  ellipse(0, 0, 12, 12); // Sol

  // --- Planeta 1 ---
  stroke(255, 0, 0);
  noFill();
  float radioPlaneta1 = 50;
  ellipse(0, 0, 2*radioPlaneta1, 2*radioPlaneta1);

  pushMatrix();
  rotate(angPlaneta1 += 0.1);
  translate(radioPlaneta1, 0);
  fill(5, 250, 3);
  ellipse(0, 0, 10, 10);
  popMatrix();

  // --- Planeta 2 con lunas ---
  stroke(255);
  noFill();
  float radioPlaneta2 = 100;
  ellipse(0, 0, 2*radioPlaneta2, 2*radioPlaneta2);

  pushMatrix();
  rotate(angPlaneta2 += 0.05);
  translate(radioPlaneta2, 0);
  fill(11, 160, 10);
  ellipse(0, 0, 10, 10);

  // Órbita Luna 1
  stroke(128);
  noFill();
  float radioLuna1 = 30;
  ellipse(0, 0, 2*radioLuna1, 2*radioLuna1);

  pushMatrix();
  rotate(angLuna1 += 0.1);
  translate(radioLuna1, 0);
  fill(8, 228, 255);
  ellipse(0, 0, 4, 4);
  popMatrix();

  // Órbita Luna 2
  float radioLuna2 = 60;
  ellipse(0, 0, 2*radioLuna2, 2*radioLuna2);

  pushMatrix();
  rotate(angLuna2 += 0.05);
  translate(radioLuna2, 0);
  fill(17, 137, 152);
  ellipse(0, 0, 4, 4);
  popMatrix();

  popMatrix(); // Fin del Planeta 2 y lunas

  // --- Planeta 3 ---
  stroke(255);
  noFill();
  float radioPlaneta3 = 150;
  ellipse(0, 0, 2*radioPlaneta3, 2*radioPlaneta3);

  pushMatrix();
  rotate(angPlaneta3 += 0.025);
  translate(radioPlaneta3, 0);
  fill(7, 88, 6);
  ellipse(0, 0, 10, 10);
  popMatrix();

  popMatrix(); // Fin del Sol y su sistema
}

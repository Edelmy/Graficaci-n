
// Un sistema planetario 
// Chay Edelmy
float angPlaneta1 = 0.0,
      angPlaneta2 = PI/3.0,
      angPlaneta3 = 2.0*PI/3.0,
      angLuna1 = 0.0,
      angLuna2 = PI;

void setup() {
  size(400, 400);
  stroke(255);
  strokeWeight(1);  
  frameRate(30);
}

void draw() {
  background(0);

  // Centro 
  translate(width/2, height/2);

  // Sol
  fill(#F1FA03);
  noStroke();
  ellipse(0, 0, 20, 20);

  // Planeta 1
  stroke(255);
  noFill();
  float radioPlaneta1 = width / 8.0;  
  ellipse(0, 0, 2 * radioPlaneta1, 2 * radioPlaneta1);

  pushMatrix();
  rotate(angPlaneta1 += 0.1);
  translate(radioPlaneta1, 0);
  fill(#05FA03);
  noStroke();
  ellipse(0, 0, 15, 15);
  popMatrix();

  //Planeta 2 ---
  stroke(255);
  noFill();
  float radioPlaneta2 = width / 4.0;  
  ellipse(0, 0, 2 * radioPlaneta2, 2 * radioPlaneta2);

  pushMatrix();
  rotate(angPlaneta2 += 0.05);
  translate(radioPlaneta2, 0);
  fill(#0BA00A);
  noStroke();
  ellipse(0, 0, 3, 3);  

  //  lunas del Planeta 2
  stroke(128);
  noFill();

  //  Luna 1
  float radioLuna1 = radioPlaneta2 / 3.0;  
  ellipse(0, 0, 2 * radioLuna1, 2 * radioLuna1);

  pushMatrix();
  rotate(angLuna1 += 0.1);
  translate(radioLuna1, 0);
  fill(#08E4FF);
  noStroke();
  ellipse(0, 0, 3, 3); 
  popMatrix();

  // Luna 2 
  float radioLuna2 = radioPlaneta2 / 4.0;  // ~25
  ellipse(0, 0, 2 * radioLuna2, 2 * radioLuna2);

  pushMatrix();
  rotate(angLuna2 += 0.05);
  translate(radioLuna2, 0);
  fill(#118998);
  noStroke();
  ellipse(0, 0, 3, 3);  
  popMatrix();

  popMatrix();  // Planeta 2 y lunas

  // Planeta 3 
  stroke(255);
  noFill();
  float radioPlaneta3 = width * 3.0 / 8.0;  
  ellipse(0, 0, 2 * radioPlaneta3, 2 * radioPlaneta3);

  pushMatrix();
  rotate(angPlaneta3 += 0.025);
  translate(radioPlaneta3, 0);
  fill(#075806);
  noStroke();
  ellipse(0, 0, 15, 15);
  popMatrix();
}

//Chay Edelmy
//Ambiente 3D
void setup() {
  size(800, 600, P3D);//activo modo 3D
}

void draw() {
  background(150, 200, 255); //Fondo
  lights(); //iluminación
  
  // mover la escena al centro
  translate(width/2, height/2 + 100, -200); //posiciona el punto de vista
  rotateY(map(mouseX, 0, width, -PI, PI)); // girar con el ratón
  
  // suelo
  fill(100, 250, 100); //rellno
  noStroke();
  pushMatrix();
  translate(0, 100, 0);
  box(800, 10, 800);
  popMatrix();
  
  // Casa
  fill(200, 250, 100); // paredes
  pushMatrix();
  translate(-100, 0, 0);
  box(100, 100, 100); // cuerpo
  popMatrix();
  
  // Casa 2
  fill(20, 255, 100); // paredes
  pushMatrix();
  translate(50, 0, 0);
  box(100, 100, 100); // cuerpo
  popMatrix();
   // techo2
  fill(150, 0, 0);
  pushMatrix();
  translate(60, -50, 0);
  box(125, 40, 120);
  popMatrix();
   // puerta2
  fill(120, 70, 30); // color café
  pushMatrix();
  translate(50, 25, 52); // al frente (Z positiva)
  box(40, 50, 4); // ancho, alto, grosor
  popMatrix();
  
  // techo1
  fill(150, 0, 0);
  pushMatrix();
  translate(-100, -70, 0);
  box(120, 40, 120);
  popMatrix();
  // puerta1
  fill(120, 70, 30); // color café
  pushMatrix();
  translate(-100, 25, 52); // al frente (Z positiva)
  box(30, 50, 4); // ancho, alto, grosor
  popMatrix();
  
  // ventana
  fill(120, 200, 255); // color celeste (vidrio)
  pushMatrix();
  translate(-70, -20, 52.5); // un poco más arriba de la puerta
  box(30, 30, 2);
  popMatrix();
  
  // --- árbol ---
  // tronco
  fill(120, 70, 30);
  pushMatrix();
  translate(150, 20, 0);
  box(20, 80, 20);
  popMatrix();
  
  // copa (una esfera verde)
  fill(30, 150, 30);
  pushMatrix();
  translate(150, -40, 0);
  sphere(60);
  popMatrix();
  
  //2
  // tronco
  fill(120, 70, 30);
  pushMatrix();
  translate(-200, 30, 100);  // tronco 2 (a la izquierda y un poco al fondo)
  box(20, 80, 20);
  popMatrix();

fill(30, 150, 30);
pushMatrix();
translate(-200, -30, 100); // copa 2 (encima del tronco 2)
sphere(75);
popMatrix();
 
}

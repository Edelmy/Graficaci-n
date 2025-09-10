//Desarrollar un programa en processing que permita dibujar polígonos de n lados
/* Para ello hay que implementar una función poligon con los siguientes
parámetros: centro (dos enteros), radio (entero) y número de lados del
polígono (entero) */
//Chay Edelmy
void setup(){
  size (500,500); //tl
  background(0,200,0);  //fondo
  poligono(200,100,100,6); //intento1
}
 void poligono (int centroA, int centroB, int radio, int num){
  //Se necesita determinar el incremento del ángulo entre vértice
  float angulo=0;
  beginShape();
  //itera para encontrar en radianes y usar los valores dados
  for (int i = 0; i < num; i++) {
    
    angulo = i * TWO_PI / num; // Calcula el ángulo en radianes
    float x = centroA + cos(angulo) * radio;
    float y = centroB + sin(angulo) * radio;
    vertex(x, y);
  }
  endShape(CLOSE);
}

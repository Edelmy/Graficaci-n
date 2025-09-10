/*Desarrollar un programa en processing que permita dibujar un gradiente de color, de forma que la primera fila de la ventana se dibujará de un color de partida y la última
fila de un color de destino. Las filas intermedias se dibujaran de forma que llevarán acabo una graduación lineal de colores entre las dos filas inicial y final. */
//Chay Edelmy
void setup(){
  size (500, 500);
  int R=0, G=50, B=100;
  int R_final=255, G_final=200, B_final=50;
  gradient(R, G, B, R_final, G_final, B_final);
}

void gradient (int R, int G, int B, int R_final, int G_final, int B_final){
  int x=150;
  int y=100;
  int w=200; 
  int h=250;
  //Interpolación lineal de cada component de color
  //Las variables width y height nos devuelven en todo momento el ancho y alto de la ventana de la aplicación
  float dR = (float)(R_final - R) / h;
  float dG = (float)(G_final - G) / h;
  float dB = (float)(B_final - B) / h;

  float r = R, g = G, b = B;

  // recorrer todas las filas del rectángulo
  for (int i = 0; i < h; i++) {
    stroke(r, g, b);
    line(x, y + i, x + w, y + i);

    // aumentar color poco a poco
    r += dR;
    g += dG;
    b += dB;
  }
}

//ChayEdelmy
//Representar gráficamente el histograma, de forma que su anchura sea de 256, su altura de 100, y cada valor se dibuje como una línea 
PImage foto1;
int[] histograma = new int[256];

void setup() {
  
  size(512, 512 + 120); // ajusta según tu imagen si quieres
  background(0);

  // Carga la imagen y escala a 512x512 para que encaje
  foto1 = loadImage("Green.jpg");
  foto1.filter(GRAY);

  image(foto1, 0, 0, 512, 512);

  // Inicializa histograma
  for (int i = 0; i < 256; i++) histograma[i] = 0;

  // Calcula histograma
  for (int i = 0; i < foto1.width; i++) {
    for (int j = 0; j < foto1.height; j++) {
      int gris = int(red(foto1.get(i, j)));
      histograma[gris]++;
    }
  }

  // Encuentra el máximo
  int mayor = 0;
  for (int i = 0; i < 256; i++) {
    if (histograma[i] > mayor) mayor = histograma[i];
  }

  // Dibuja histograma
  int histHeight = 100;        // altura máxima de las barras
  int yOffset = 512 + 10;      // empieza debajo de la imagen
  stroke(255);                  
  strokeWeight(2);              

  float barraAncho = (float)512 / 256; // ancho de cada barra
  for (int i = 0; i < 256; i++) {
    float altura = map(histograma[i], 0, mayor, 0, histHeight);
    float x = i * barraAncho;
    line(x, yOffset + histHeight, x, yOffset + histHeight - altura);
  }

  println("Histograma dibujado");
}

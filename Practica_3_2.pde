/*Calcular y visualizar el histograma de una imagen
• El histograma representa el número de veces que un determinado valor de
intensidad está presente en una imagen concreta
• Puede calcularse para cada uno de los 3 canales por separado, o de forma
integrada para los 3 canales (histograma RGB) */
//ChayEdelmy

PImage foto1; 
int[] histograma = new int[256];

void setup(){
  size(1091 , 768);

  // Cargar la imagen y convertirla a escala de grises (1 canal)
  foto1 = loadImage("Green.jpg");
  foto1.filter(GRAY); // modifica la imagen convirtiéndola en escala de grises (1 canal)
  image(foto1, 0, 0); // se dibuja despues de cargar la imagen

  // Inicializar el histograma a 0
  for (int i = 0; i < 256; i++) histograma[i] = 0;

  // Recorrer cada píxel de la imagen
  for (int i = 0; i < foto1.width; i++){
    for (int j = 0; j < foto1.height; j++){
      // El rojo nos devuelve el correspondiente valor de gris tras la conversión anterior
      int gris = int(red(foto1.get(i, j))); 
      
      // Incrementar el contador del histograma para este nivel de gris
      histograma[gris]++;
    }// j
  }// i

  // Determinar el máximo valor de los almacenados en histograma
  int mayor = 0; // cantidad máxima de píxeles
  int lugar = 0; // nivel de gris donde ocurre el máximo
  for (int k = 0; k < histograma.length; k++){
    if (histograma[k] > mayor){
      mayor = histograma[k];
      lugar = k;
    }
  }

  // Mostrar resultados en consola
  println(histograma); // imprime todo el histograma
  println("El valor mayor: " + mayor + " en la posición: " + lugar);
}// fin

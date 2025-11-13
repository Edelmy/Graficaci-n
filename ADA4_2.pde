//Chay Dzul Edelmy 
//ADA 4.2 Graficación
//5to Semestre, grupo 1
float posx; //indican dónde está el centro de la pelota en la ventana
float posy;
float velocidad=20;
int diametro=50;
int r=0;
int g=255;//color verde al principio
int b=0;
int contador=0;
void setup(){
  size (400,400, P3D);
  posx=width/2;
  posy=height/2;
}
//Dibujar un circulo en el centro de la pantalla
void draw(){
 background(0);//para limpiar con el fondo
 noStroke(); //pelota sin borde
 
 bordes(); //llama a la funcion para detectar bordes y cambiar de color
 
  pushMatrix(); //guarda estado
// Mueve la pelota al punto de las coordenadas controladas por posx y posy
  translate(posx, posy, 0);

// Son los brillos reflejados en la superficie de la esfera
  lightSpecular(255, 255, 255);

// Luz direccional blanca desde arriba y adelante como si fuera una lampara gigante
  directionalLight(255, 255, 255, 0, -1, -1);

// Es lo que hace que el brillo blanco de la luz direccional se note
  specular(200, 200, 200);

// Color actual de la pelota
  fill(r, g, b);

// Dibujar la esfera con iluminación y sombreado
  sphere(diametro / 2);

  popMatrix(); //devuelve al estado original
 
//Agregar un contador de 'choques con los bordes' y mostrarlo en pantalla.
 fill(0,255,0);
 textSize(20);
 text("Contador de choques: " + contador ,100,40);
  
}
void keyPressed(){
  //Hacer que el círculo se mueva con las flechas del teclado
  // si presiona w arriba
  if (key == 'w'|| keyCode==UP) {
   posy-=velocidad;//restar a posy hace que la pelota suba
   print ("se mueve\n");
  }
  // Si presiona s abajo
  if (key == 's'|| keyCode==DOWN) {
    posy+=velocidad;//sumar a posy hace que la pelota baje
  }
  if (key=='d'||keyCode==RIGHT){
    posx+=velocidad; //sumar a posx hace que la pelota se mueva a la derecha
  }
  if (key=='a'||keyCode==LEFT){
    posx-=velocidad; //restar a posx ocasiona que la pelota se mueva a la izquierda
  }
  
}
void bordes(){
  //Programar un límite: si el círculo toca los bordes de la ventana, cambia de color.
   //Detecta el borde izquierdo si la posición del centro de la pelota es menor que su radio
  if (posx < diametro/2) {
    posx = diametro; //empuja a la pelota hacia la derecha hasta que esté completamente dentro
    r=int(random(255));//cada vez que choque cambia de color de manera aleatoria
    g=int(random(255));
    b=int(random(255));
    contador++; //Suma cada colisión
  }
  //borde derecho
  if (posx>width-(diametro/2)){ //si se acerca al borde derecho, se mueve a la izquierda para evitar que se salga
    posx=width-diametro;
    r=int(random(255));
    g=int(random(255));
    b=int(random(255));
    contador++;
  }
  //borde superior
  //Si el centro está más arriba que su propio radio, parte de la pelota se saldría de la ventana, así que se empujamos hacia abajo
  if (posy < diametro/2){
    posy=diametro;
    r=int(random(255));
    g=int(random(255));
    b=int(random(255));
    contador++;
  }
  //borde inferior
  //Si el centro está demasiado cerca del borde inferior, parte de la pelota se saldría por eso se mueve hacia arriba para que quede dentro de nuevo
  if (posy>height-(diametro/2)){
    posy=height-diametro;
    r=int(random(255));
    g=int(random(255));
    b=int(random(255));
    contador++;
  }

}

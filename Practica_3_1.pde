//Chay Edelmy
//Hay que asegurarse que foto.jpg está en el directorio "data"
/*Crear una nueva aplicación. Agregad una imagen en el directorio data Mostrad la imagen de forma que ésta se vea en su totalidad en la área de la
ventana, manteniendo las proporciones originales y centrada (transformación isotrópica centrada)
*/
PImage foto1;
void setup(){
size(1091 , 768);
background(0);
foto1 = loadImage("Green.jpg");

}
void draw(){
  image(foto1, 0, 0,width,height);

}




//   image(foto1, 0, 0, width/2, height);

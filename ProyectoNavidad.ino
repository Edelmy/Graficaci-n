//Librerías para manejar el teclado y el servomotor
#include <Keypad.h> 
#include <Servo.h>

#define FILAS 4 // Número de filas del teclado (4 porque es 4x4)
#define COLUMNAS 4 // Número de columnas del teclado
//Se definen los pines utilizados
int LED_RALERTA = 13;
int LED_VACCESO = 12;
int BUZZER = 3;
int SERVO_PIN = 2;
bool alarmaActiva = false;   // Esta bandera indica si la alarma está encendida

Servo caja; // Servo para abrir/cerrar la compuerta
// Mapa de teclas del keypad
char keys[FILAS][COLUMNAS] = {
   { '1','2','3', 'A' },
   { '4','5','6', 'B' },
   { '7','8','9', 'C' },
   { '*','0','#', 'D' }
};
//Pines del keypad
byte Fpines[FILAS] = {11, 10, 9, 8}; // F1-F4 (Filas)
byte Cpines[COLUMNAS] = {7, 6, 5, 4}; // C1-C4 (Columnas)
// Se crea el objeto keypad
Keypad keypad = Keypad(makeKeymap(keys), Fpines, Cpines, FILAS, COLUMNAS);

// Variables para contraseñas
String pinIngresado = "";
String santa = "1234";
String reno  = "7770";
String duende = "0000";
//Lista de regalos (solo para imprimir)
String regalos[] = {"Carro", "Dinero", "Carbón premium"};
int total=3;
// Notas musicales para el buzzer
#define NOTE_C3  131
#define NOTE_D3  147
#define NOTE_E3  165
#define NOTE_F3  175
#define NOTE_G3  196
#define NOTE_A3  220
#define NOTE_B3  247
#define NOTE_C4  262
#define NOTE_D4  294
#define NOTE_E4  330
#define NOTE_F4  349
#define NOTE_G4  392
#define NOTE_A4  440
#define NOTE_B4  494
#define NOTE_C5  523
#define NOTE_D5  587
#define NOTE_E5  659
#define NOTE_F5  698
#define NOTE_G5  784
#define NOTE_A5  880
#define NOTE_B5  988
// Duración base para calcular la duración de cada nota
#define tempo 1000
#define mult 1.3
// =============================
unsigned long lastNote = 0; // Guarda cuándo se tocó la última nota
int noteIndex = 0; // Índice de nota actual
// Arreglo con notas de la melodía
int notas[] = {
  NOTE_B3, NOTE_F4, NOTE_F4, NOTE_G4, NOTE_F4,
  NOTE_E4, NOTE_D4, NOTE_D4, NOTE_D4, NOTE_G4,
  NOTE_G4, NOTE_A4, NOTE_G4, NOTE_F4, NOTE_E4,
  NOTE_E4, NOTE_E4, NOTE_A4, NOTE_A4, NOTE_B4,
  NOTE_A4, NOTE_G4, NOTE_F4, NOTE_D4, NOTE_B3,
  NOTE_B3, NOTE_D4, NOTE_G4, NOTE_E4, NOTE_F4
};
// Duración correspondiente de cada nota
int duraciones[] = {
  tempo/4, tempo/4, tempo/8, tempo/8, tempo/8,
  tempo/8, tempo/4, tempo/4, tempo/4, tempo/4,
  tempo/8, tempo/8, tempo/8, tempo/8, tempo/4,
  tempo/4, tempo/4, tempo/4, tempo/8, tempo/8,
  tempo/8, tempo/8, tempo/4, tempo/4, tempo/8,
  tempo/8, tempo/4, tempo/4, tempo/4, tempo/2
};

int totalNotas = sizeof(notas) / sizeof(int); // Cantidad total de notas
// Función que reproduce la canción sin detener la ejecución del programa
void song() {
  unsigned long now = millis();

  // Verifica si ya pasó el tiempo de la nota actual
  if (now - lastNote >= (unsigned long) duraciones[noteIndex]) {

    // Apagar nota anterior
    noTone(BUZZER);

    // Avanza a la siguiente nota, o reinicia si ya llegó al final
    noteIndex++;
    if (noteIndex >= totalNotas) noteIndex = 0;

    // Toca la nueva nota
    tone(BUZZER, notas[noteIndex], duraciones[noteIndex] - 5);

    // Guarda el tiempo en que inició la nota nueva
    lastNote = now;
  }
}

//===================================================================
void setup() {
  Serial.begin(9600); //Comunicación serial
  //Configuración de pines
  pinMode(LED_RALERTA, OUTPUT);
  pinMode(LED_VACCESO, OUTPUT);
  pinMode(BUZZER, OUTPUT);
  
  caja.attach(SERVO_PIN);
  caja.write(0); // Servo comienza con la compuerta cerrada

  Serial.println("=== Archivos seguros ===");
  Serial.println("Esperando contraseñas...");
  
}

void loop() {
  char key = keypad.getKey(); //Lee si se presionó una tecla

  if (key) {

    // Si lo que se presionó es un número, se agrega al PIN
    if (key >= '0' && key <= '9') {
      pinIngresado += key;
      Serial.print("*");   // Se muestra asterisco para ocultar el PIN
    }

    // Cuando ya se ingresaron 4 dígitos, se revisa el PIN
    if (pinIngresado.length() == 4) {
      revisarnip(); //Verifica contraseña
      pinIngresado = ""; // Reinicia la entrada
      Serial.println("\nEsperando contraseñas...");
    }
  }
}
//===============================================================
void revisarnip() {
  Serial.println("");
  // Verifica contraseña de Santa
  if (pinIngresado == santa) {
  Serial.println("Acceso concedido - ls/Regalos/");
  digitalWrite(LED_VACCESO, HIGH); //Enciende led verde
//Muestra la lista de regalos
  Serial.println("Lista de regalos:");
  for (int i = 0; i < total; i++) {
    Serial.println("- " + regalos[i]);
  }
  abrirCompuerta(); //Abre compuerta de la caja
//Después de un tiempo el led se apaga 
  delay(2000);
  digitalWrite(LED_VACCESO, LOW);
  return;
}
  // Verfica contraseña del reno
  if (pinIngresado == reno) {
    Serial.println("Acceso concedido (solo lectura) - ls/Regalos/");
    digitalWrite(LED_VACCESO, HIGH); //Enciende Led verde
	
    Serial.println("Lista de regalos:"); //Mustra la lista de regalos
  	for (int i = 0; i < total; i++) {
    Serial.println("- " + regalos[i]);
  	}
    abrirCompuerta(); //Abre compuerta de regalos
//Después de un tiempo el led verde se apaga
    delay(2000);
    digitalWrite(LED_VACCESO, LOW);
    return;
  }

  // Verfica contraseña del duende
  if (pinIngresado == duende) {
    Serial.println("Permiso denegado");
    Serial.println("¡Para desactivar la alarma es necesario llamar a Santa!");
    digitalWrite(LED_RALERTA, HIGH); //Se enciende el led rojo
     alarmaActiva = true;      // Se activa la alarma
  activarAlarma(); //Entra al modo alarma
    delay(2000);
    digitalWrite(LED_RALERTA, LOW);
    return;
  }
  // sino coincide con ninguna contraseña
  Serial.println("contraseña incorrecta");
}
//================================================================================
//Función para abrir/Cerrar el servo
void abrirCompuerta() { //Se encarga de abrir la compuerta
  for (int i = 0; i <= 90; i++) {
    caja.write(i);
    delay(10);
  }
  delay(5000); //Determina el tiempo que se mantiene abierto
  for (int i = 90; i >= 0; i--) {//Se encarga de cerrar la compuerta
    caja.write(i);
    delay(10);
  }
}
//=================================================================================
//Función que ejecuta la alarma y pide el PIN correcto
void activarAlarma() {
  	 Serial.println("ALARMA ACTIVA - esperando a Santa...");
  digitalWrite(LED_RALERTA, HIGH);

  String intento = ""; //Aquí se guarda el PIN que se intenta ingresar

  unsigned long lastBlink = 0; // Para controlar el parpadeo del LED
  bool ledState = false; //Estado actual del LED

  while (alarmaActiva) {
    //Reproduce la canción sin detener el programa
    song();
    // Lee teclado dentro del modo alarma
    char k = keypad.getKey();
    if (k) {
      intento += k;
      Serial.print("*");
    }
    // Cuando ya tiene 4 dígitos, revisa si es Santa
    if (intento.length() == 4) {

      if (intento == santa) { //Solo Santa puede apagar la alarma
        Serial.println("\nSanta detectado. Apagando alarma...");

        alarmaActiva = false;
        noTone(BUZZER); //Detiene la canción

        digitalWrite(LED_RALERTA, LOW); //Se apaga el led rojo
        digitalWrite(LED_VACCESO, HIGH);//Cambia por el led verde

        
        //Despliega lista de regalos
        Serial.println("Lista de regalos: ");
        for (int i = 0; i < total; i++) {
        Serial.println("- " + regalos[i]);
  	    }
        abrirCompuerta(); // Abre caja
        delay(1000);
        digitalWrite(LED_VACCESO, LOW);
        return;
      }
      //Sino era santa vuelve a pedir el PIN
      Serial.println("\nPIN incorrecto");
      intento = "";
    }

    // Control del parpadeo del LED rojo durante la alarma
    // millis() devuelve el tiempo que ha pasado desde que inició el Arduino
    //lastBlink guarda el momento en el que el LED cambió por última vez.
    if (millis() - lastBlink >= 120) {
      ledState = !ledState; // Alterna entre encendido y apagado
      digitalWrite(LED_RALERTA, ledState); // Refleja el cambio en el LED
      lastBlink = millis(); //Registra el último parpadeo
    }
  }
}

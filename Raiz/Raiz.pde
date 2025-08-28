import ddf.minim.*;
// Atributos
private Protagonista prota; /** Atributo de la clase del protagonista*/
private JoyPad joypad; /** Atributo de l clase para movimiento */
//
private ArrayList<Lucky> luckyblock; /** Atributo para generar los luckyblocks*/
private ArrayList<Enemigo> enemigos; /** Atributo de la clase del enemigo (generico)*/
private ArrayList<Proyectil> proyectilesEnemigos = new ArrayList<Proyectil>(); 
//
private ArrayList<Lucky> luckyblockNivel2;
private ArrayList<Enemigo> enemigosNivel2;
private ArrayList<Proyectil> proyectilesEnemigosNivel2 = new ArrayList<Proyectil>(); 
//
private boolean muteado = false;
private float lastFrameTime; 
private PFont fontTitulo;
private PFont fontTexto;
private ArrayList<Integer> mejoresPuntuaciones = new ArrayList<Integer>();
private MensajeFlotante mensajeFlotante; 
private PImage fondo1;
private PImage fondo2;
private PImage lucky;
private PImage enemigo1;
private PImage enemigo2;
private PImage enemigo3;
private PImage protagonista;

/** Estados del videojuego*/
final int ESTADO_MENU = 0;
final int ESTADO_JUGANDO = 1;
final int ESTADO_GAMEOVER = 2;
final int ESTADO_NIVEL2MENU = 7;
private int estadoActual = ESTADO_MENU;
final int ESTADO_PAUSA = 3;
final int ESTADO_NIVEL2 = 4;
final int ESTADO_CREDITOS = 5;
final int ESTADO_HORDA= 6;

private boolean HORDA= false;
private int nivel = 1;
private GestorAudio audio;
private ManejadorNivel nivel1;
private ManejadorNivel nivel2;
private GestorPantallas gestorPantallas;

// minim
Minim minim;
AudioPlayer player;
AudioPlayer musicaMenu;
AudioPlayer musicaJuego;
AudioPlayer musicaNivel2;
AudioPlayer musicavictoria;
AudioPlayer musicaderrota;
boolean musicaActiva = true;
float volumen = 0.5; // Volumen inicial (0-1)

/** */

void setup() {
    size(1600, 800); /** Lienzo de la pantalla*/
    fontTitulo = createFont("Arial Bold", 48);
    fontTexto = createFont("Arial", 32);
    mensajeFlotante = new MensajeFlotante(fontTexto); 
    fondo1 = loadImage("fondo1.png");
    fondo2 = loadImage("fondo2.png");
    lucky = loadImage("lucky.png");
    enemigo1 = loadImage("enemigo1.png");
    enemigo2= loadImage("enemigo2.png");
    enemigo3= loadImage("enemigo3.png");
    protagonista = loadImage("protagonista.png");
    protagonista.resize(50,70);
    enemigo2.resize(80,80);
    enemigo3.resize(50, 60);
    lucky.resize(50, 50);
    enemigo1.resize(50, 60);
    fondo1.resize(width, height);
    fondo2.resize(width, height);
    minim = new Minim(this);
    audio = new GestorAudio(this);
     // Cargar músicas
    //setVolumen(volumen);
    
    
    
    frameRate(60); // Ajustar a 60 FPS
    prota = new Protagonista();
    prota.setPosicion(new PVector(width / 2, height / 2));
    prota.setVelocidad(new PVector(5, 5)); // Establecer la velocidad base
    joypad = new JoyPad(); /** Clase joypad para movimiento del protagonista */
    luckyblock = new ArrayList<Lucky>(); /** Se crea un arraylist para la generacion de multiples cofres de la suerte */
    
    
    /** Generacion de Luckyblocks de manera aleatoria en una cantidad de 15 esparcidos por el mapa*/
    for (int j = 0; j < 15; j++) {
        PVector posicionL = new PVector(random(0, 2400), random(0, 1600));
        int tipo = (int) random(2);
        float duracion = random(0,15);
        if (tipo == 0){ /** Tipo de suerte*/
            luckyblock.add(new LuckyBonus(posicionL,(int) random(0,200),duracion));
        }
        else if (tipo == 1){
            luckyblock.add(new LuckyPenalty(posicionL,(int) random(0,150),duracion));
        }
        luckyblock.add(new Lucky(posicionL, lucky));
    }
    
    /** Se inicializa una Lista de 8 enemigos cuya posicion será aleatoria en un espacio de 2400x1600 */
    enemigos = new ArrayList<Enemigo>(); /** Se crea un arraylist para la generacion de multiples enemigos de la suerte */
    for (int i = 0; i < 8; i++) { 
        PVector posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigos.add(new EnemigoFuerte(posicion,enemigo2));
        posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigos.add(new EnemigoLento(posicion,enemigo1)); //corregir
        posicion = new PVector(random(0, 2400), random(0, 1600)); 
        enemigos.add(new EnemigoRapido(posicion,enemigo3));
    }
     enemigosNivel2 = new ArrayList<Enemigo>();
     for (int i = 0; i < 8; i++) { 
        PVector posicionNivel2 = new PVector(random(0, 2400), random(0, 1600));
        enemigosNivel2.add(new EnemigoFuerte(posicionNivel2,enemigo2));
        posicionNivel2 = new PVector(random(0, 2400), random(0, 1600));
        enemigosNivel2.add(new EnemigoLento(posicionNivel2,enemigo1)); //corregir
        posicionNivel2 = new PVector(random(0, 2400), random(0, 1600)); 
        enemigosNivel2.add(new EnemigoRapido(posicionNivel2,enemigo3));
    }
    luckyblockNivel2 = new ArrayList<Lucky>();
    for (int j = 0; j < 15; j++) {
        PVector posicionL2 = new PVector(random(0, 2400), random(0, 1600));
        int tipo = (int) random(2);
        float duracion = random(0,15);
        if (tipo == 0){
            luckyblockNivel2.add(new LuckyBonus(posicionL2,(int) random(0,200),duracion));
        }
        else if (tipo == 1){
            luckyblockNivel2.add(new LuckyPenalty(posicionL2,(int) random(0,150),duracion));
        }
        luckyblockNivel2.add(new Lucky(posicionL2, lucky));
    }
    proyectilesEnemigosNivel2 = new ArrayList<Proyectil>();
    
    
     nivel1 = new ManejadorNivel(fondo1, enemigos, proyectilesEnemigos, luckyblock);
     nivel2 = new ManejadorNivel(fondo2, enemigosNivel2, proyectilesEnemigosNivel2, luckyblockNivel2);
     gestorPantallas = new GestorPantallas(fontTitulo, fontTexto, mejoresPuntuaciones, volumen, musicaActiva, prota);
}

void draw() {
    float currentTime = millis() / 1000.0; /** Almacena el tiempo transcurrido desde el ultimo fotograma renderizado por la funcion millis*/
    float deltaTime = currentTime - lastFrameTime;  /**Calcular deltaTime por medio de la reste entre el lastframetime y el currenttime*/
    lastFrameTime = currentTime; /** Actualizar el tiempo del último cuadro*/
    prota.getScore();
    audio.actualizar(estadoActual);
   
    /** Maquina de estado que llama a diferentes funciones segun el estado actual*/
    switch(estadoActual){
      case ESTADO_MENU:
       gestorPantallas.dibujarMenu(); /** Llama a la funcion de dibujar el menu al abrir la aplicacion para poder interactuar con las opciones del juego */
        break;
      case ESTADO_JUGANDO:
        actualizarJuego(deltaTime); /** Es el estado referido para el primer nivel del videojuego */
        break;
      case ESTADO_GAMEOVER:
        gestorPantallas.mostrarGameOver(); /** Es la pantalla que se mostrara al perder la cantidad de vidas totales del protagonista*/
        break;
      case ESTADO_PAUSA:
        gestorPantallas.mostrarPausa(); /** Es el estado de pausa que se puede acceder en cualquier momento mediante la tecla P*/
        break;
      case ESTADO_NIVEL2MENU:
        gestorPantallas.mostrarNivel2(); 
        break; 
        case ESTADO_NIVEL2:
        actualizarNivel2(deltaTime);
        break;
        case ESTADO_HORDA:
        actualizarHorda(deltaTime);
        break;
        case ESTADO_CREDITOS:
        gestorPantallas.mostrarGameEnd();
        break;
        
    }
    
        
    
}
 
    
/** Logica especifica del nivel 1 */
void actualizarJuego(float deltaTime) {
    nivel1.actualizar(deltaTime, prota, joypad, () -> { /** se envia deltaTime,protagonista,joypad y () se refiere a la funcion que verifica constantemente que el score del */
        if (prota.getScore() >= 500 && nivel == 1 && HORDA == false) { /** protagonista sea menor a 500 y no se encuentre en estado horda de otra manera el estado se cambiaria a nivel2 MENU*/
            nivel = 2;                                                  /** y la generacion de enemigos y niveles se reiniciaria*/
            estadoActual = ESTADO_NIVEL2MENU; 
            reiniciarGeneracionNivel2();  /** Comentar despues*/
        } else if (enemigos.isEmpty()) { /** De no haber enemigos en campo se entra en gameover*/
            estadoActual = ESTADO_GAMEOVER; 
        }
    });
}


// Nivel 2
void actualizarNivel2(float deltaTime) {
    nivel2.actualizar(deltaTime, prota, joypad, () -> {   
        if (prota.getScore() >= 2500) {
            estadoActual = ESTADO_CREDITOS;
        }
    });
}
// nivel horda
void actualizarHorda(float deltaTime){
     
        HORDA = true;
        nivel1.actualizar(deltaTime, prota, joypad, () -> {});
     
    
}
    

void reiniciarGeneracionNivel2() {
    // Inicializar listas si son nulas
    if (enemigosNivel2 == null) enemigosNivel2 = new ArrayList<Enemigo>();
    if (luckyblockNivel2 == null) luckyblockNivel2 = new ArrayList<Lucky>();
    if (proyectilesEnemigosNivel2 == null) proyectilesEnemigosNivel2 = new ArrayList<Proyectil>();

    // Limpiar listas de nivel 2
    enemigosNivel2.clear();
    luckyblockNivel2.clear();
    proyectilesEnemigosNivel2.clear();
    
    // Generar nuevos lucky blocks para nivel 2
    for (int j = 0; j < 20; j++) {
        PVector posicionL = new PVector(random(0, 2400), random(0, 1600));
        int tipo = (int) random(2);
        float duracion = random(0, 15);
        if (tipo == 0) {
            luckyblockNivel2.add(new LuckyBonus(posicionL, (int) random(0, 200), duracion));
        } else if (tipo == 1) {
            luckyblockNivel2.add(new LuckyPenalty(posicionL, (int) random(0, 150), duracion));
        }
        luckyblockNivel2.add(new Lucky(posicionL, lucky));
    }
    
    // Generar nuevos enemigos para nivel 2 con estadísticas diferentes
    for (int i = 0; i < 10; i++) {
        PVector posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigosNivel2.add(new EnemigoFuerte(posicion, enemigo2));
        posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigosNivel2.add(new EnemigoLento(posicion, enemigo1));
        posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigosNivel2.add(new EnemigoRapido(posicion, enemigo3));
    }
}


void reiniciarJuego() {
    nivel = 1;
    HORDA = false;
    proyectilesEnemigos.clear(); // Limpiar proyectiles enemigos
    enemigos.clear(); // Limpiar enemigos
    luckyblock.clear(); // Limpiar lucky blocks
    setup();
}

void agregarEnemigos(int cantidad) {
    for (int i = 0; i < cantidad; i++) {
        PVector posicion = new PVector(random(0, 2400), random(0, 1600)); // Generar una posición aleatoria
        // Crear un nuevo enemigo (puedes elegir el tipo de enemigo que desees)
        Enemigo nuevoEnemigo = new EnemigoFuerte(posicion, enemigo2); // Ejemplo de enemigo fuerte
        enemigos.add(nuevoEnemigo); // Agregar el nuevo enemigo a la lista
    }
}

void mousePressed() { 
    // ====== BOTÓN INICIAR JUEGO ======
    if (mouseX > width / 2 - 150 && mouseX < width / 2 + 150 &&
        mouseY > 500 && mouseY < 570) {
      estadoActual = ESTADO_JUGANDO;
    }
    
    // ====== BOTÓN MODO HORDA ======
    else if (mouseX > width / 2 - 150 && mouseX < width / 2 + 150 &&
             mouseY > 600 && mouseY < 670) {
      estadoActual = ESTADO_HORDA; // Cambiar a tu estado especial para horda
    }
    
    // ====== BOTÓN SALIR ======
    else if (mouseX > width / 2 - 150 && mouseX < width / 2 + 150 &&
             mouseY > 700 && mouseY < 770) {
      exit();
    }
  }



void mostrarMensaje(String mensaje, float duracion, int colores) {
    mensajeFlotante.mostrar(mensaje, duracion, colores);
}
    
void stop() {
  audio.detener();
  super.stop();
}

public void keyPressed() {
  if (estadoActual == ESTADO_JUGANDO || estadoActual == ESTADO_NIVEL2 || estadoActual == ESTADO_HORDA){ /** El protagonista se movera siempre y cuando se encuentre en algunos de los estados de juego*/

    if (key == 'w' || keyCode == UP) { /** mover hacia arriba con flecha o w*/

        joypad.setUpPressed(true);
    }
    if (key == 's' || keyCode == DOWN) { /** mover hacia arriba con flecha o s*/

        joypad.setDownPressed(true);
    }
    if (key == 'd' || keyCode == RIGHT) { /** mover hacia arriba con flecha o d*/

        joypad.setRightPressed(true);
    }
    if (key == 'a' || keyCode == LEFT) { /** mover hacia arriba con flecha o a*/

        joypad.setLeftPressed(true);
    }
    
    if (key == ' ') { /** Ejecutar disparo con la tecla espacio*/

        prota.disparar();
    }
  }
    
    if (key == 'p' || key == 'P') { /** cambiar el estado de juego a pausa siempre y cuando se encuentre en algunos de los estados de juego (no incluye menus obviamente)*/
    if (estadoActual == ESTADO_JUGANDO || estadoActual == ESTADO_NIVEL2 || estadoActual == ESTADO_HORDA ) {
        estadoActual = ESTADO_PAUSA;
    } else if (estadoActual == ESTADO_PAUSA) { /** en caso de estar en el estado de pausa se reanuda el juego*/
        estadoActual = ESTADO_JUGANDO;
    }
}
    if (key == ESC) { /** cerrar aplicacion */
        exit();
    }
    if (key == 'r' && estadoActual == ESTADO_GAMEOVER) { /** En el caso que el estado se haya cambiado a GAMEOVER el jugador presionando r puede volver al estado jugando desde el primer nivel*/
        reiniciarJuego(); /** reinicia el juego en su totalidad antes de cambiar el estado*/
        estadoActual = ESTADO_JUGANDO;
    }
    if (key == 'e' && estadoActual == ESTADO_GAMEOVER) { /** En otro caso el jugador puede optar por ingresar al menu princial desde el gameover*/
        reiniciarJuego(); /** reinicia el juego en su totalidad antes de cambiar el estado*/
        estadoActual = ESTADO_MENU;
    }
    
    if (key == 'n' && estadoActual == ESTADO_NIVEL2MENU) {
        estadoActual = ESTADO_NIVEL2;
        reiniciarGeneracionNivel2();
    }
    
    
  
  if (key == 'r' && estadoActual == ESTADO_GAMEOVER) { /** por alguna razon esta duplicado, ver */
    audio.detenerMusicaActual(); // detener cualquier música activa
    reiniciarJuego();
    estadoActual = ESTADO_JUGANDO;
    
    
    
}



if (key == 'e' && estadoActual == ESTADO_GAMEOVER) { /** por alguna razon esta duplicado, ver */
    audio.detenerMusicaActual();
    reiniciarJuego();
    estadoActual = ESTADO_MENU; // volver al menu desde el gameover
}



if (key == 'r' && estadoActual == ESTADO_CREDITOS) {
    audio.detenerMusicaActual();
    reiniciarJuego();
    estadoActual = ESTADO_MENU;
}


if (key == 'm' || key == 'M') {
    if (muteado == false){
      muteado = true;
    }  else {
      muteado = false;
    }
    audio.toggleMute(muteado);
}
if (key == '{'){
  audio.setVolumen(volumen - 0.1);
   println("Volumen actual: " + nf(volumen, 1, 2));
}
if (key == '}'){
  audio.setVolumen(volumen + 0.1);
  println("Volumen actual: " + nf(volumen, 1, 2));
}
    
 }
    

public void keyReleased() { /** control de teclas cuando dejan de ser pulsadas */
    if (key == 'w' || keyCode == UP) {
        joypad.setUpPressed(false);
    }
    if (key == 's' || keyCode == DOWN) {
        joypad.setDownPressed(false);
    }
    if (key == 'd' || keyCode == RIGHT) {
        joypad.setRightPressed(false);
    }
    if (key == 'a' || keyCode == LEFT) {
        joypad.setLeftPressed(false);
    }
}

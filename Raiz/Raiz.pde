import ddf.minim.*;
// Atributos
private Protagonista prota; /** Atributo de la clase del protagonista*/
private JoyPad joypad; /** Atributo de l clase para movimiento */
//
private ArrayList<Lucky> luckyblock; /** Atributo para generar los luckyblocks*/
private ArrayList<Enemigo> enemigos; /** Atributo de la clase del enemigo (generico)*/
private ArrayList<Proyectil> proyectilesEnemigos = new ArrayList<Proyectil>(); /** Atributo para generrar los proyectiles enemigos*/
//
private ArrayList<Lucky> luckyblockNivel2; /** Atributo para generar los luckyblocks del nivel 2*/
private ArrayList<Enemigo> enemigosNivel2; /** Atributo para generar los enemigos del nivel 2*/
private ArrayList<Proyectil> proyectilesEnemigosNivel2 = new ArrayList<Proyectil>(); /** Atributo para generar los proyectiles enemigos*/
//
private boolean muteado = false;
private float lastFrameTime;  /** Variable para el uso del deltaTime*/
private PFont fontTitulo; /** Fuente del titulo*/
private PFont fontTexto; /** Fuente de textos*/
private ArrayList<Integer> mejoresPuntuaciones = new ArrayList<Integer>();
private MensajeFlotante mensajeFlotante; 
private PImage fondo1; /** Imagen del nivel 1*/
private PImage fondo2; /** Imagen del nivel 2*/
private PImage lucky; /** Imagen del cofre de la suerte*/
private PImage enemigo1; /** Imagen del enemigo 1*/
private PImage enemigo2; /** Imagen del enemigo 2*/
private PImage enemigo3; /** Imagen del enemigo 3*/
private PImage protagonista; /** Imagen del protagonista*/

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
int estadoG;

private boolean HORDA= false;
private int nivel = 1; /** atributo para gestion del nivel */
private GestorAudio audio;
private ManejadorNivel nivel1; /** atributo para el manejador de nivel */
private ManejadorNivel nivel2; /** atributo para el manejador de nivel 2*/
private GestorPantallas gestorPantallas; /** */

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
    fontTitulo = createFont("Arial Bold", 48); /** Fuente del titulo */
    fontTexto = createFont("Arial", 32); /** Fuente del texto*/
    mensajeFlotante = new MensajeFlotante(fontTexto); 
    fondo1 = loadImage("fondo1.png"); /** Imagen del nivel 1*/
    fondo2 = loadImage("fondo2.png"); /** Imagen del nivel 2*/
    lucky = loadImage("lucky.png"); /** Imagen correspondiente al cofre de la suerte*/
    enemigo1 = loadImage("enemigo1.png"); /** Imagen correspondiente al enemigo lento*/
    enemigo2= loadImage("enemigo2.png"); /** Imagen correspondiente al enemigo fuerte*/
    enemigo3= loadImage("enemigo3.png"); /** Imagen correspondiente al enemigo rapido*/
    protagonista = loadImage("protagonista.png"); /** Imagen correspondiente al protagonista*/
    protagonista.resize(50,70); /** Redimenzionamiento del protagonista*/
    enemigo2.resize(80,80); /** Redimenzionamiento del enemigo*/
    enemigo3.resize(50, 60); /** Redimenzionamiento del enemigo*/
    lucky.resize(50, 50); /** Redimenzionamiento del cofre*/
    enemigo1.resize(50, 60); /** Redimenzionamiento del enemigo*/
    fondo1.resize(width, height); /** Redimenzionamiento del nivel1*/
    fondo2.resize(width, height); /** Redimenzionamiento del nivel2*/
    minim = new Minim(this);
    audio = new GestorAudio(this);
     // Cargar músicas
    //setVolumen(volumen);
    
    
    
    frameRate(60);  /**Ajustar a 60 FPS */ /** */
    prota = new Protagonista(); /** Inicializar protagonista*/
    prota.setPosicion(new PVector(width / 2, height / 2)); /** Establecer posicion en el centro de la pantalla*/
    prota.setVelocidad(new PVector(5, 5));   /**Establecer la velocidad base*/
    joypad = new JoyPad(); /** Clase joypad para movimiento del protagonista */
    luckyblock = new ArrayList<Lucky>(); /** Se crea un arraylist para la generacion de multiples cofres de la suerte */
    
    
    /** Generacion de Luckyblocks de manera aleatoria en una cantidad de 15 esparcidos por el mapa*/
    for (int j = 0; j < 15; j++) {
        PVector posicionL = new PVector(random(0, 2400), random(0, 1600));
        int tipo = (int) random(2);
        float duracion = random(0,15); /** Duracion del buffo o penalizacion*/
        if (tipo == 0){ /** Tipo de suerte*/
            luckyblock.add(new LuckyBonus(posicionL,(int) random(0,200),duracion));
        }
        else if (tipo == 1){
            luckyblock.add(new LuckyPenalty(posicionL,(int) random(0,150),duracion));
        }
        luckyblock.add(new Lucky(posicionL, lucky));
    }
    
    /** Se inicializa una Lista de 36 enemigos cuya posicion será aleatoria en un espacio de 2400x1600 */
    enemigos = new ArrayList<Enemigo>(); /** Se crea un arraylist para la generacion de multiples enemigos de la suerte */
    for (int i = 0; i < 36; i++) { 
        PVector posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigos.add(new EnemigoFuerte(posicion,enemigo2));
        posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigos.add(new EnemigoLento(posicion,enemigo1)); //corregir
        posicion = new PVector(random(0, 2400), random(0, 1600)); 
        enemigos.add(new EnemigoRapido(posicion,enemigo3));
    }
    /** Se inicializa una Lista de 50 enemigos para el nivel 2 cuya posicion será aleatoria en un espacio de 2400x1600 */
     enemigosNivel2 = new ArrayList<Enemigo>();
     for (int i = 0; i < 50; i++) { 
        PVector posicionNivel2 = new PVector(random(0, 2400), random(0, 1600));
        enemigosNivel2.add(new EnemigoFuerte(posicionNivel2,enemigo2));
        posicionNivel2 = new PVector(random(0, 2400), random(0, 1600));
        enemigosNivel2.add(new EnemigoLento(posicionNivel2,enemigo1)); //corregir
        posicionNivel2 = new PVector(random(0, 2400), random(0, 1600)); 
        enemigosNivel2.add(new EnemigoRapido(posicionNivel2,enemigo3));
    }
    /** Generacion de Luckyblocks de manera aleatoria para el nivel 2 en una cantidad de 12 esparcidos por el mapa*/
    luckyblockNivel2 = new ArrayList<Lucky>();
    for (int j = 0; j < 12; j++) {
        PVector posicionL2 = new PVector(random(0, 2400), random(0, 1600));
        int tipo = (int) random(2);  /** Tipo de suerte*/
        float duracion = random(0,15); /** Duracion del buffo o penalizacion*/
        if (tipo == 0){
            luckyblockNivel2.add(new LuckyBonus(posicionL2,(int) random(0,200),duracion));
        }
        else if (tipo == 1){
            luckyblockNivel2.add(new LuckyPenalty(posicionL2,(int) random(0,150),duracion));
        }
        luckyblockNivel2.add(new Lucky(posicionL2, lucky));
    }
    proyectilesEnemigosNivel2 = new ArrayList<Proyectil>(); /** Inicializacion de la clase proyectil*/
    
    
     nivel1 = new ManejadorNivel(fondo1, enemigos, proyectilesEnemigos, luckyblock); /** Inicializar el manejador de nivel 1*/
     nivel2 = new ManejadorNivel(fondo2, enemigosNivel2, proyectilesEnemigosNivel2, luckyblockNivel2); /** Inicializar el manejador de nivel 2*/
     gestorPantallas = new GestorPantallas(fontTitulo, fontTexto, mejoresPuntuaciones, volumen, musicaActiva, prota); /** Inicializar gestor de pantallas*/
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
        gestorPantallas.mostrarNivel2(); /** Estado que pausa el juego momentaneamente para informar que se alcanzaron las condiciones para jugar el nivel 2*/
        break; 
        case ESTADO_NIVEL2:
        actualizarNivel2(deltaTime); /** Estado correspondiente al nivel 2*/
        break;
        case ESTADO_HORDA:
        actualizarHorda(deltaTime); /** Estado correspondiente al modo horda*/
        break;
        case ESTADO_CREDITOS:
        gestorPantallas.mostrarGameEnd(); /** Estado que muestra la pantalla del fin de la demo */
        break;
        
    }
    
        
    
}
 
    
/** Logica especifica del nivel 1 */
void actualizarJuego(float deltaTime) {
    nivel1.actualizar(deltaTime, prota, joypad, () -> { /** se envia deltaTime,protagonista,joypad y () se refiere a la funcion que verifica constantemente que el score del */
        if (prota.getScore() >= 500 && nivel == 1 && HORDA == false) { /** protagonista sea menor a 500 y no se encuentre en estado horda de otra manera el estado se cambiaria a nivel2 MENU*/
            nivel = 2;                                                  /** y la generacion de enemigos y niveles se reiniciaria*/
            estadoActual = ESTADO_NIVEL2MENU; 
            reiniciarGeneracionNivel2();  /** Se regenera el campo de juego para tener niveles distintos entre partidas */
        } else if (enemigos.isEmpty()) { /** De no haber enemigos en campo se entra en gameover*/
            estadoActual = ESTADO_GAMEOVER; 
        }
    });
}


/** Logica del nivel 2*/
void actualizarNivel2(float deltaTime) {
    nivel2.actualizar(deltaTime, prota, joypad, () -> {   
        if (prota.getScore() >= 2500) {
            estadoActual = ESTADO_CREDITOS;
        }
    });
}

/** Logica del nivel horda*/
void actualizarHorda(float deltaTime){
     
        HORDA = true;
        nivel1.actualizar(deltaTime, prota, joypad, () -> {});
     
    
}
    
/** Reset de generacion se enemigos y cofres de la suerte para el nivel 2 */
void reiniciarGeneracionNivel2() {
    /** Inicializar las listas por si el jugador llegase a vaciarlas (eliminar todos los enemigos o usar todos los cofres)*/
    if (enemigosNivel2 == null) enemigosNivel2 = new ArrayList<Enemigo>();
    if (luckyblockNivel2 == null) luckyblockNivel2 = new ArrayList<Lucky>();
    if (proyectilesEnemigosNivel2 == null) proyectilesEnemigosNivel2 = new ArrayList<Proyectil>();

    /** Limpiar listas del nivel 2*/
    enemigosNivel2.clear();
    luckyblockNivel2.clear();
    proyectilesEnemigosNivel2.clear();
    
    /**Generar nuevos lucky blocks para nivel 2 */ 
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
    
    /**Generar nuevos enemigos para nivel 2 con estadísticas diferentes */
    for (int i = 0; i < 10; i++) {
        PVector posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigosNivel2.add(new EnemigoFuerte(posicion, enemigo2));
        posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigosNivel2.add(new EnemigoLento(posicion, enemigo1));
        posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigosNivel2.add(new EnemigoRapido(posicion, enemigo3));
    }
}

/** Reset de del videojuego en caso de llegar al estado_creditos o perder en el nivel 2, etc */
void reiniciarJuego() {
    nivel = 1; /** volver al nivel 1 */
    HORDA = false; /** Desactivar el modo horda */
    proyectilesEnemigos.clear(); /**Limpiar proyectiles enemigos */ 
    enemigos.clear(); /**Limpiar enemigos */ 
    luckyblock.clear(); /**Limpiar lucky blocks */ 
    setup();
}

/** Funcion para agregar una cierta cantidad de enemigos */ /** */

void agregarEnemigos(int cantidad) {
    for (int i = 0; i < cantidad; i++) {
        PVector posicion = new PVector(random(0, 2400), random(0, 1600));       
        Enemigo nuevoEnemigo = new EnemigoFuerte(posicion, enemigo2); 
        enemigos.add(nuevoEnemigo); 
    }
}

/** MousePressed para interactuar en el videojuego con el mouse */ /** */

void mousePressed() { 
    /** ====== BOTÓN INICIAR JUEGO ====== */ 
    if (mouseX > width / 2 - 150 && mouseX < width / 2 + 150 &&
        mouseY > 500 && mouseY < 570) {
      estadoActual = ESTADO_JUGANDO;
    }
    
    /** ====== BOTÓN Modo Horda ====== */ 
    else if (mouseX > width / 2 - 150 && mouseX < width / 2 + 150 &&
             mouseY > 600 && mouseY < 670) {
      estadoActual = ESTADO_HORDA; // Cambiar a tu estado especial para horda
    }
    
    /** ====== BOTÓN Salir ====== */ 
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


  /**keyPressed para interaccion del input con el videojuego */
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
      estadoG = estadoActual;  /** Guarda el estado actual entre las 3 posibilidades */
      estadoActual = ESTADO_PAUSA;
    } else if (estadoActual == ESTADO_PAUSA) { /** en caso de estar en el estado de pausa se reanuda el juego*/
        estadoActual = estadoG; /** Vuelve al estado anterior */
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
    
    if (key == 'n' && estadoActual == ESTADO_NIVEL2MENU) {  /** Avanzar el estado Nivel 2 mediante la pulsacion de la tecla n*/
        estadoActual = ESTADO_NIVEL2;  
        reiniciarGeneracionNivel2();  /** Reiniciar generacion de enemigos*/
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



if (key == 'r' && estadoActual == ESTADO_CREDITOS) {  /** Estado creditos del videojuego, se regresa al menu mediante la r */
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
    
  /** control de teclas cuando dejan de ser pulsadas */
public void keyReleased() { 
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

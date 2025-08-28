import ddf.minim.*;
// Atributos
private Protagonista prota;
private JoyPad joypad;
//
private ArrayList<Lucky> luckyblock;
private ArrayList<Enemigo> enemigos;
private ArrayList<Proyectil> proyectilesEnemigos = new ArrayList<Proyectil>(); 
//
private ArrayList<Lucky> luckyblockNivel2;
private ArrayList<Enemigo> enemigosNivel2;
private ArrayList<Proyectil> proyectilesEnemigosNivel2 = new ArrayList<Proyectil>(); 
//
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
boolean musicaActiva = true;
float volumen = 0.5; // Volumen inicial (0-1)

void setup() {
    size(1600, 800);
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
    musicaMenu = minim.loadFile("menu.wav");
    musicaJuego = minim.loadFile("nivel1.mp3");
    musicaNivel2 = minim.loadFile("nivel2.wav");
    setVolumen(volumen);
    
    
    
    frameRate(60); // Ajustar a 60 FPS
    prota = new Protagonista();
    prota.setPosicion(new PVector(width / 2, height / 2));
    prota.setVelocidad(new PVector(5, 5)); // Establecer la velocidad base
    joypad = new JoyPad();
    luckyblock = new ArrayList<Lucky>();
    
    
    // Inicializar lucky blocks
    for (int j = 0; j < 15; j++) {
        PVector posicionL = new PVector(random(0, 2400), random(0, 1600));
        int tipo = (int) random(2);
        float duracion = random(0,15);
        if (tipo == 0){
            luckyblock.add(new LuckyBonus(posicionL,(int) random(0,200),duracion));
        }
        else if (tipo == 1){
            luckyblock.add(new LuckyPenalty(posicionL,(int) random(0,150),duracion));
        }
        luckyblock.add(new Lucky(posicionL, lucky));
    }
    
    // Inicializar enemigos
    enemigos = new ArrayList<Enemigo>();
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
    float currentTime = millis() / 1000.0; // Tiempo actual en segundos
    float deltaTime = currentTime - lastFrameTime; // Calcular deltaTime
    lastFrameTime = currentTime; // Actualizar el tiempo del último cuadro
    prota.getScore();
    audio.actualizar(estadoActual);
    println("Estado: " + estadoActual + " Prota pos: " + prota.getPosicion());

    switch(estadoActual){
      case ESTADO_MENU:
       gestorPantallas.dibujarMenu();
        break;
      case ESTADO_JUGANDO:
        actualizarJuego(deltaTime);
        break;
      case ESTADO_GAMEOVER:
        gestorPantallas.mostrarGameOver();
        break;
      case ESTADO_PAUSA:
        gestorPantallas.mostrarPausa();
        break;
      case ESTADO_NIVEL2MENU:
        gestorPantallas.mostrarNivel2();
        break; 
        case ESTADO_NIVEL2:
        actualizarNivel2(deltaTime);
        break;
        case ESTADO_HORDA:
        HORDA = true;
        
    }
    
        
    
}
 
    
// Nivel 1
void actualizarJuego(float deltaTime) {
    nivel1.actualizar(deltaTime, prota, joypad, () -> {
        if (prota.getScore() >= 500 && nivel == 1) {
            nivel = 2;
            estadoActual = ESTADO_NIVEL2MENU; 
            reiniciarGeneracionNivel2(); 
        } else if (enemigos.isEmpty()) {
            estadoActual = ESTADO_MENU; 
        }
    });
}


// Nivel 2
void actualizarNivel2(float deltaTime) {
    nivel2.actualizar(deltaTime, prota, joypad, () -> {   
        if (enemigos.isEmpty()) {
            estadoActual = ESTADO_MENU;
        }
    });
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
  
    if (estadoActual == ESTADO_MENU) {
    // Control de volumen en menú
    if (mouseX > width-200 && mouseX < width-170 && mouseY > 50 && mouseY < 80) {
      setVolumen(max(0, volumen-0.1)); // Bajar volumen
    }
    else if (mouseX > width-150 && mouseX < width-120 && mouseY > 50 && mouseY < 80) {
      setVolumen(min(1, volumen+0.1)); // Subir volumen
    }
    else if (mouseX > width-100 && mouseX < width-40 && mouseY > 50 && mouseY < 80) {
      //GestorAudio.toggleMute(); // Alternar mute
    }
  }
    if (estadoActual == ESTADO_MENU) {
        if (mouseX > width / 2 - 100 && mouseX < width / 2 + 100) {
            if (mouseY > 450 && mouseY < 510) {
                estadoActual = ESTADO_JUGANDO;
            } else if (mouseY > 530 && mouseY < 590) {
                exit();
            }
        }
    }/* else if (estadoActual == ESTADO_NIVEL2) {
        if (mouseX > width / 2 - 100 && mouseX < width / 2 + 100) {
            if (mouseY > height / 2 + 20 && mouseY < height / 2 + 60) {
              
              estadoActual = ESTADO_NIVEL2;
              reiniciarGeneracionNivel2();
                 
            }
        }
    }*/
}


void mostrarMensaje(String mensaje, float duracion, int colores) {
    mensajeFlotante.mostrar(mensaje, duracion, colores);
}


void setVolumen(float v) {
  volumen = v;
  musicaMenu.setGain(map(volumen, 0, 1, -80, 0)); // -80 es silencio, 0 es volumen máximo
  musicaJuego.setGain(map(volumen, 0, 1, -80, 0));
  musicaNivel2.setGain(map(volumen, 0, 1, -80, 0));
}    
    
void stop() {
  audio.detener();
  super.stop();
}

public void keyPressed() {
  if (estadoActual == ESTADO_JUGANDO || estadoActual == ESTADO_NIVEL2){
    if (key == 'w' || keyCode == UP) {
        joypad.setUpPressed(true);
    }
    if (key == 's' || keyCode == DOWN) {
        joypad.setDownPressed(true);
    }
    if (key == 'd' || keyCode == RIGHT) {
        joypad.setRightPressed(true);
    }
    if (key == 'a' || keyCode == LEFT) {
        joypad.setLeftPressed(true);
    }
    
    if (key == ' ') {
        prota.disparar();
    }
  }
    
    if (key == 'p' || key == 'P') {
    if (estadoActual == ESTADO_JUGANDO) {
        estadoActual = ESTADO_PAUSA;
    } else if (estadoActual == ESTADO_PAUSA) {
        estadoActual = ESTADO_JUGANDO;
    }
}
    if (key == ESC) {
        exit();
    }
    if (key == 'r' && estadoActual == ESTADO_GAMEOVER) {
        reiniciarJuego();
        estadoActual = ESTADO_JUGANDO;
    }
    
    if (key == 'n' && estadoActual == ESTADO_NIVEL2MENU) {
        estadoActual = ESTADO_NIVEL2;
        reiniciarGeneracionNivel2();
    }
    
    if (key == 'm' || key == 'M') {
    audio.toggleMute();
  }
    
 }
    

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

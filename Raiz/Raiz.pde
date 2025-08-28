import ddf.minim.*;
// Atributos
private Protagonista prota;
private JoyPad joypad;
private ArrayList<Lucky> luckyblock;
private ArrayList<Enemigo> enemigos;
private ArrayList<Proyectil> proyectilesEnemigos = new ArrayList<Proyectil>(); 
private float lastFrameTime; 
private PFont fontTitulo;
private PFont fontTexto;
private ArrayList<Integer> mejoresPuntuaciones = new ArrayList<Integer>();
private MensajeFlotante mensajeFlotante; // Declarar sin inicializar
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
     nivel1 = new ManejadorNivel(fondo1, enemigos, proyectilesEnemigos, luckyblock);
     nivel2 = new ManejadorNivel(fondo2, enemigos, proyectilesEnemigos, luckyblock);
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
      case ESTADO_NIVEL2:
        gestorPantallas.mostrarNivel2();
        actualizarNivel2(deltaTime);
        break;  
        case ESTADO_HORDA:
        HORDA = true;
        
    }
}
 
    
// Nivel 1
void actualizarJuego(float deltaTime) {
    nivel1.actualizar(deltaTime, prota, joypad, () -> {
        if (enemigos.isEmpty()) {
            estadoActual = ESTADO_MENU;}
        if (prota.getScore() >= 500 && nivel == 1) {
            nivel = 2;
            estadoActual = ESTADO_NIVEL2;
            prota.setPosicion(new PVector(width / 2, height / 2));
            reiniciarGeneracionNivel2();
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
    // Limpiar listas
    proyectilesEnemigos.clear();
    enemigos.clear();
    luckyblock.clear();
    
    // Generar nuevos lucky blocks
    for (int j = 0; j < 20; j++) { // Aumentar la cantidad de lucky blocks
        PVector posicionL = new PVector(random(0, 2400), random(0, 1600));
        int tipo = (int) random(2);
        float duracion = random(0, 15);
        if (tipo == 0) {
            luckyblock.add(new LuckyBonus(posicionL, (int) random(0, 200), duracion));
        } else if (tipo == 1) {
            luckyblock.add(new LuckyPenalty(posicionL, (int) random(0, 150),duracion));
        }
        luckyblock.add(new Lucky(posicionL, lucky));
    }
    
    // Generar nuevos enemigos con estadísticas diferentes
    for (int i = 0; i < 10; i++) { // Aumentar la cantidad de enemigos
        PVector posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigos.add(new EnemigoFuerte(posicion, enemigo2)); // Enemigos más fuertes
        posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigos.add(new EnemigoLento(posicion, enemigo1)); // Enemigos lentos
        posicion = new PVector(random(0, 2400), random(0, 1600));
        enemigos.add(new EnemigoRapido(posicion, enemigo3)); // Enemigos rápidos
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
    } else if (estadoActual == ESTADO_NIVEL2) {
        if (mouseX > width / 2 - 100 && mouseX < width / 2 + 100) {
            if (mouseY > height / 2 + 20 && mouseY < height / 2 + 60) {
                estadoActual = ESTADO_JUGANDO; // Comenzar el segundo nivel
                reiniciarGeneracionNivel2(); // Reiniciar la generación de enemigos y lucky blocks
            }
        }
    }
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
  if (estadoActual == ESTADO_JUGANDO){
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







/* Cementerio

/*
        Antigua logica del juego nivel 1

        image(fondo1,0,0);
        translate(width / 2 - prota.getPosicion().x, height / 2 - prota.getPosicion().y); // Seguimiento de cámara
        
        // Actualizar y mostrar el protagonista
        prota.update(deltaTime);
        prota.display(protagonista);
        
        // Actualizar y mostrar enemigos
        for (int i = enemigos.size() - 1; i >= 0; i--) {
            Enemigo e = enemigos.get(i);
            e.update(prota, deltaTime);
            e.display();
            
            // Agregar proyectiles enemigos
            for (Proyectil p : e.getProyectiles()) {
                if (!proyectilesEnemigos.contains(p)) {
                    proyectilesEnemigos.add(p);
                }
            }
        }
        
        // Mostrar lucky blocks y detectar colisiones
          for (int i = luckyblock.size() - 1; i >= 0; i--) {
              Lucky lucky = luckyblock.get(i);
              lucky.display();
              
        // Detectar colisión con el protagonista
              if (PVector.dist(lucky.posicion, prota.getPosicion()) < 20) { // Ajusta el valor según el tamaño
                  lucky.aplicarEfecto(prota); // Aplicar efecto al protagonista
                  luckyblock.remove(i); // Eliminar lucky block después de recogerlo
              }
          }
        
        // Actualizar y mostrar proyectiles enemigos
        for (int i = proyectilesEnemigos.size() - 1; i >= 0; i--) {
            Proyectil p = proyectilesEnemigos.get(i);
            p.update(deltaTime);
            p.display();
            
            // Detectar colisión con el protagonista
            if (PVector.dist(p.getPosicion(), prota.getPosicion()) < prota.getRadio() + p.getRadio()) {
                proyectilesEnemigos.remove(i);
                prota.recibirDano();
                if (prota.getVidas() <= 0) {
                    prota.guardarPuntuacion();
                    estadoActual = ESTADO_GAMEOVER;
                }
            }
            
            // Eliminar proyectiles fuera de pantalla
            if (p.estaFueraDePantalla()) {
                proyectilesEnemigos.remove(i);
            }
        }
        
        // Colisión de proyectiles del jugador con enemigos
        for (Proyectil pJugador : prota.getProyectiles()) {
            for (int i = enemigos.size() - 1; i >= 0; i--) {
                Enemigo e = enemigos.get(i);
                
                float distancia = PVector.dist(pJugador.getPosicion(), e.getPosicion());
                float sumaRadios = e.getRadio() + pJugador.getRadio();
                
                if (distancia < sumaRadios) {
                    // Eliminar el enemigo
                    enemigos.remove(i);
                    prota.aumentarPuntaje(100);
                    
                    
                    /* Bloqueado solo para modo supervivencia
                    if (HORDA == true){
                    
                    }
                    // Agregar dos nuevos enemigos
                    for (int j = 0; j < 1; j++) {
                        PVector nuevaPosicion = new PVector(random(0, 2400), random(0, 1600));
                         enemigos.add(new Enemigo(nuevaPosicion));
                         enemigos.add(new EnemigoLento(nuevaPosicion,enemigo1));
                         enemigos.add(new Enemigo(nuevaPosicion));
                         enemigos.add(new EnemigoRapido(nuevaPosicion,enemigo3));
                         
                    }*/
                     /*
                    break; // Salir del bucle después de eliminar un enemigo
                }
            }
        }
        
        
        
        
        
        
        
         // Dibujar mensaje
        mensajeFlotante.dibujar();
        mensajeFlotante.actualizar(deltaTime);
        
        if (prota.getScore() >= 500 && nivel == 1) {
          nivel = 2;
          estadoActual = ESTADO_NIVEL2;
          reiniciarGeneracionNivel2(); // Llama a un método para reiniciar la generación
      }
        
        // Controles del jugador - MOVIMIENTO
        if (joypad.isUpPressed()) {
            prota.mover(0, deltaTime);
        }
        if (joypad.isRightPressed()) {
            prota.mover(1, deltaTime);
        }
        if (joypad.isDownPressed()) {
            prota.mover(2, deltaTime);
        }
        if (joypad.isLeftPressed()) {
            prota.mover(3, deltaTime);
        }
        
        // Mostrar HUD
        mostrarHUD();
        
        if (prota.getScore() >= 500 && nivel == 1) {
        nivel = 2;
        estadoActual = ESTADO_NIVEL2;
        }
        
    }
        
*/


/*    Logica del nivel 2


void actualizarNivel2(float deltaTime) {
  
        image(fondo2,0,0);
        translate(width / 2 - prota.getPosicion().x, height / 2 - prota.getPosicion().y); // Seguimiento de cámara
        
        // Actualizar y mostrar el protagonista
        prota.update(deltaTime);
        prota.display(protagonista);
        
        // Actualizar y mostrar enemigos
        for (int i = enemigos.size() - 1; i >= 0; i--) {
            Enemigo e = enemigos.get(i);
            e.update(prota, deltaTime);
            e.display();
            
            // Agregar proyectiles enemigos
            for (Proyectil p : e.getProyectiles()) {
                if (!proyectilesEnemigos.contains(p)) {
                    proyectilesEnemigos.add(p);
                }
            }
        }
        
        // Mostrar lucky blocks y detectar colisiones
          for (int i = luckyblock.size() - 1; i >= 0; i--) {
              Lucky lucky = luckyblock.get(i);
              lucky.display();
              
        // Detectar colisión con el protagonista
              if (PVector.dist(lucky.posicion, prota.getPosicion()) < 20) { // Ajusta el valor según el tamaño
                  lucky.aplicarEfecto(prota); // Aplicar efecto al protagonista
                  luckyblock.remove(i); // Eliminar lucky block después de recogerlo
              }
          }
        
        // Actualizar y mostrar proyectiles enemigos
        for (int i = proyectilesEnemigos.size() - 1; i >= 0; i--) {
            Proyectil p = proyectilesEnemigos.get(i);
            p.update(deltaTime);
            p.display();
            
            // Detectar colisión con el protagonista
            if (PVector.dist(p.getPosicion(), prota.getPosicion()) < prota.getRadio() + p.getRadio()) {
                proyectilesEnemigos.remove(i);
                prota.recibirDano();
                if (prota.getVidas() <= 0) {
                    estadoActual = ESTADO_GAMEOVER;
                    prota.guardarPuntuacion();
                }
            }
            
            // Eliminar proyectiles fuera de pantalla
            if (p.estaFueraDePantalla()) {
                proyectilesEnemigos.remove(i);
            }
        }
        
        // Colisión de proyectiles del jugador con enemigos
        for (Proyectil pJugador : prota.getProyectiles()) {
            for (int i = enemigos.size() - 1; i >= 0; i--) {
                Enemigo e = enemigos.get(i);
                
                float distancia = PVector.dist(pJugador.getPosicion(), e.getPosicion());
                float sumaRadios = e.getRadio() + pJugador.getRadio();
                
                if (distancia < sumaRadios) {
                    // Eliminar el enemigo
                    enemigos.remove(i);
                    prota.aumentarPuntaje(100); // Aumentar el puntaje
                    
                     /*
                    // Agregar dos nuevos enemigos
                    for (int j = 0; j < 1; j++) {
                        PVector nuevaPosicion = new PVector(random(0, 2400), random(0, 1600));
                         enemigos.add(new Enemigo(nuevaPosicion));
                         enemigos.add(new EnemigoLento(nuevaPosicion,enemigo1));
                         enemigos.add(new Enemigo(nuevaPosicion));
                         enemigos.add(new EnemigoRapido(nuevaPosicion,enemigo3));
                         
                    }
                    */
                    
                    /*
                    break; // Salir del bucle después de eliminar un enemigo
                }
            }
        }
        
         // Dibujar mensaje
        mensajeFlotante.dibujar();
        mensajeFlotante.actualizar(deltaTime);
        
        // Controles del jugador - MOVIMIENTO
        if (joypad.isUpPressed()) {
            prota.mover(0, deltaTime);
        }
        if (joypad.isRightPressed()) {
            prota.mover(1, deltaTime);
        }
        if (joypad.isDownPressed()) {
            prota.mover(2, deltaTime);
        }
        if (joypad.isLeftPressed()) {
            prota.mover(3, deltaTime);
        }
        
        // Mostrar HUD
        mostrarHUD();
        
        if (enemigos.isEmpty()) {
        estadoActual = ESTADO_MENU;
        return;
    }
  
  
}
*/


/* Antigua visual

void dibujarMenu() {
    background(40);
    
    // Título del juego
    fill(255, 215, 0); // Color dorado
    textFont(fontTitulo);
    textAlign(CENTER, CENTER);
    text("SPACE SHOOTER", width / 2, 100);
    
    // Botones de control de volumen
    fill(255);
    rect(width-200, 50, 30, 30); // Botón -
    rect(width-150, 50, 30, 30); // Botón +
    rect(width-100, 50, 60, 30); // Botón mute
    
    // Textos
    text("Volumen: " + int(volumen*100) + "%", width-200, 40);
    text("-", width-195, 70); 
    text("+", width-145, 70);
    text(musicaActiva ? "Mute" : "Unmute", width-95, 70);
    
    // Mejores puntuaciones
    fill(200);
    textFont(fontTexto);
    textAlign(CENTER);
    text("MEJORES PUNTUACIONES", width / 2, 180);
    
    // Lista de puntuaciones
    fill(255);
    for (int i = 0; i < min(5, mejoresPuntuaciones.size()); i++) {
        text((i + 1) + ". " + mejoresPuntuaciones.get(i), width / 2, 230 + i * 40);
    } 
    
    // Botón Iniciar Juego
    fill(0, 255, 0);
    rect(width / 2 - 100, 450, 200, 60, 10);
    fill(0);
    textAlign(CENTER, CENTER);
    text("INICIAR JUEGO", width / 2, 480);
    
    // Botón Salir
    fill(255, 0, 0);
    rect(width / 2 - 100, 530, 200, 60, 10);
    fill(0);
    text("SALIR", width / 2, 560);
}

void mostrarPausa() {
    fill(0, 150);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(48);
    text("PAUSA", width / 2, height / 2 - 40);
    textSize(24);
    text("Presiona 'P' para reanudar", width / 2, height / 2 + 10);
    // Botón para silenciar/reactivar música
    // Añadir controles de audio en la pausa
  fill(255);
  rect(width/2 - 100, height/2 + 60, 200, 40);
  fill(0);
  text("Mute/Unmute [M]", width/2 - 80, height/2 + 85);
}


void mostrarGameOver() {
    background(0);
    fill(255);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width / 2, height / 2);
    textSize(30);
    text("Score: " + prota.getScore(), width / 2, height / 2 + 60);
    text("Presiona 'R' para reiniciar", width / 2, height / 2 + 100);
}

void mostrarHUD() {
    pushMatrix();
    resetMatrix(); 
    fill(255);
    textSize(24);
    textAlign(LEFT);
    text("Vidas: " + prota.getVidas(), 20, 40);
    text("Score: " + prota.getScore(), 20, 70); // Obtener el puntaje desde Protagonista
    popMatrix();
}

void mostrarNivel2() {
    background(0);
    fill(255);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("¡Felicidades! Has alcanzado el Nivel 2", width / 2, height / 2 - 40);
    textSize(30);
    text("Haz click aqui para continuar", width / 2, height / 2 + 20);
}
*/

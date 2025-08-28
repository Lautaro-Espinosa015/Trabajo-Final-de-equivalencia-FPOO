class Cementerio{

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



/*// Para colisión de proyectiles enemigos con el jugador
for (int i = proyectilesEnemigos.size()-1; i >= 0; i--) {
    Proyectil p = proyectilesEnemigos.get(i);
    
    float distancia = PVector.dist(p.getPosicion(), prota.getPosicion());
    float sumaRadios = prota.getRadio() + p.getRadio();
    
    if (distancia < sumaRadios) {
        proyectilesEnemigos.remove(i);
        prota.recibirDano();
        if (prota.getVidas() <= 0) {
            gameOver = true;
        }
    }
}
// Para colisión de proyectiles del jugador con enemigos
for (Proyectil pJugador : prota.getProyectiles()) {
    for (int i = enemigos.size()-1; i >= 0; i--) {
        Enemigo e = enemigos.get(i);
        
        float distancia = PVector.dist(pJugador.getPosicion(), e.getPosicion());
        float sumaRadios = e.getRadio() + pJugador.getRadio();
        
        if (distancia < sumaRadios) {
            enemigos.remove(i);
            score += 100;
            break;
        }
    }
}*/

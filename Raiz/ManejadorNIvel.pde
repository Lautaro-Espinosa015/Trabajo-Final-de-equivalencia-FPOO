class ManejadorNivel {
    PImage fondo;
    ArrayList<Enemigo> enemigos;
    ArrayList<Proyectil> proyectilesEnemigos;
    ArrayList<Lucky> luckyblock;

    ManejadorNivel(PImage fondo, ArrayList<Enemigo> enemigos, ArrayList<Proyectil> proyectilesEnemigos, ArrayList<Lucky> luckyblock) {
        this.fondo = fondo;
        this.enemigos = enemigos;
        this.proyectilesEnemigos = proyectilesEnemigos;
        this.luckyblock = luckyblock;
    }

    void actualizar(float deltaTime, Protagonista prota, JoyPad joypad, Runnable condicionEspecial) {
        // Fondo y cámara
        image(fondo, 0, 0);
        translate(width / 2 - prota.getPosicion().x, height / 2 - prota.getPosicion().y);

        // Protagonista
        prota.update(deltaTime);
        prota.display(protagonista);
        println("Joypad up: " + joypad.isUpPressed());
        println("Prota pos después de mover: " + prota.getPosicion());

        // Enemigos
        for (int i = enemigos.size() - 1; i >= 0; i--) {
            Enemigo e = enemigos.get(i);
            e.update(prota, deltaTime);
            e.display();
            for (Proyectil p : e.getProyectiles()) {
                if (!proyectilesEnemigos.contains(p)) {
                    proyectilesEnemigos.add(p);
                }
            }
        }

        // Lucky blocks
        for (int i = luckyblock.size() - 1; i >= 0; i--) {
            Lucky lucky = luckyblock.get(i);
            lucky.display();
            if (PVector.dist(lucky.posicion, prota.getPosicion()) < 20) {
                lucky.aplicarEfecto(prota);
                luckyblock.remove(i);
            }
        }

        // Proyectiles enemigos
        for (int i = proyectilesEnemigos.size() - 1; i >= 0; i--) {
            Proyectil p = proyectilesEnemigos.get(i);
            p.update(deltaTime);
            p.display();
            if (PVector.dist(p.getPosicion(), prota.getPosicion()) < prota.getRadio() + p.getRadio()) {
                proyectilesEnemigos.remove(i);
                prota.recibirDano();
                if (prota.getVidas() <= 0) {
                    estadoActual = ESTADO_GAMEOVER;
                    prota.guardarPuntuacion();
                }
            }
            if (p.estaFueraDePantalla()) {
                proyectilesEnemigos.remove(i);
            }
        }
        
        /*
        // Colisiones de proyectiles del jugador con enemigos
        for (Proyectil pJugador : prota.getProyectiles()) {
            for (int i = enemigos.size() - 1; i >= 0; i--) {
                Enemigo e = enemigos.get(i);
                if (PVector.dist(pJugador.getPosicion(), e.getPosicion()) < e.getRadio() + pJugador.getRadio()) {
                    enemigos.remove(i);
                    prota.aumentarPuntaje(100);
                    
                    // Bloqueado solo para modo supervivencia
                    if (HORDA == true){
                      if (PVector.dist(pJugador.getPosicion(), e.getPosicion()) < e.getRadio() + pJugador.getRadio()) {
                        prota.ganarVidas();
                      }
                    // Agrega un set de nuevos enemigos
                    for (int j = 0; j < 1; j++) {
                        PVector nuevaPosicion = new PVector(random(0, 2400), random(0, 1600));
                         enemigos.add(new EnemigoFuerte(nuevaPosicion,enemigo2));
                         enemigos.add(new EnemigoLento(nuevaPosicion,enemigo1));
                         PVector nuevaPosicion1 = new PVector(random(0, 2400), random(0, 1600));
                         enemigos.add(new Enemigo(nuevaPosicion1));
                         PVector nuevaPosicion2 = new PVector(random(0, 2400), random(0, 1600));
                         enemigos.add(new EnemigoRapido(nuevaPosicion2,enemigo3));                        
                    }
                    
                    }
                    break;
                }
            }
        }
        */
        
        // Colisiones de proyectiles del jugador con enemigos
for (Proyectil pJugador : prota.getProyectiles()) {
    for (int i = enemigos.size() - 1; i >= 0; i--) {
        Enemigo e = enemigos.get(i);

        // Verificar colisión
        if (PVector.dist(pJugador.getPosicion(), e.getPosicion()) < e.getRadio() + pJugador.getRadio()) {
            
            // Remover enemigo
            enemigos.remove(i);
            // Sumar puntos
            prota.aumentarPuntaje(100);
            
            // Si es modo horda, reponer enemigos
            if (HORDA) {
                prota.ganarVidas(); // Ganar vida extra
                
                // Cantidad aleatoria entre 1 y 3 enemigos nuevos
                int cantidad = int(random(1, 4));

                // Límite de enemigos activos (ej: 30)
                int limiteMaximo = 100;

                for (int j = 0; j < cantidad; j++) {
                    if (enemigos.size() >= limiteMaximo) break; // No pasar del límite

                    // Posición aleatoria
                    PVector nuevaPosicion = new PVector(random(0, 2400), random(0, 1600));
                    
                    // Tipo aleatorio
                    int tipo = int(random(4)); // 0 a 3
                    switch (tipo) {
                        case 0:
                            enemigos.add(new EnemigoFuerte(nuevaPosicion, enemigo2));
                            break;
                        case 1:
                            enemigos.add(new EnemigoLento(nuevaPosicion, enemigo1));
                            break;
                        case 2:
                            enemigos.add(new EnemigoRapido(nuevaPosicion, enemigo3));
                            break;
                        default:
                            enemigos.add(new Enemigo(nuevaPosicion)); // Genérico
                            break;
                    }
                }
            }

            break; // Salir del bucle de enemigos al detectar una colisión
        }
    }
}

        
        
        // Mensaje flotante
        mensajeFlotante.dibujar();
        mensajeFlotante.actualizar(deltaTime);

       // Controles
        if (joypad.isUpPressed()) prota.mover(0, deltaTime);
        if (joypad.isRightPressed()) prota.mover(1, deltaTime);
        if (joypad.isDownPressed()) prota.mover(2, deltaTime);
        if (joypad.isLeftPressed()) prota.mover(3, deltaTime);

        // HUD
        gestorPantallas.mostrarHUD();

        // Condición especial de cada nivel
        if (condicionEspecial != null) {
            condicionEspecial.run();
        }
    }
}

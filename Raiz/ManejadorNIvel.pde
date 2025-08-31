class ManejadorNivel {
    PImage fondo; /** imagen de fondo*/
    ArrayList<Enemigo> enemigos; /** Lista de enemigos en el nivel*/
    ArrayList<Proyectil> proyectilesEnemigos; /** Proyectiles disparados*/
    ArrayList<Lucky> luckyblock; /** bloques especiales*/
    
     
    /** Constructor*/
    
    ManejadorNivel(PImage fondo, ArrayList<Enemigo> enemigos, ArrayList<Proyectil> proyectilesEnemigos, ArrayList<Lucky> luckyblock) {
        this.fondo = fondo;
        this.enemigos = enemigos;
        this.proyectilesEnemigos = proyectilesEnemigos;
        this.luckyblock = luckyblock;
    }
    /** Metodo principal de actualizacion*/
    void actualizar(float deltaTime, Protagonista prota, JoyPad joypad, Runnable condicionEspecial) {
        
        image(fondo, 0, 0); /** Dibuja la imagen */
        translate(width / 2 - prota.getPosicion().x, height / 2 - prota.getPosicion().y); /** ajusta la camara para centrar al protagonista*/

        
        prota.update(deltaTime); /** Actualiza el estado del protagonista*/
        prota.display(protagonista); /** Dibuja al protagonista*/
        
/** */

        /** Actualiza el comportamiento de enemigos*/
        for (int i = enemigos.size() - 1; i >= 0; i--) {
            Enemigo e = enemigos.get(i);
            e.update(prota, deltaTime); /** Comportamientos, seguir, atacar */
            e.display(); /** Dibujo del enemigo*/
            for (Proyectil p : e.getProyectiles()) { /** Agrega proyectiles a la lista*/
                if (!proyectilesEnemigos.contains(p)) {
                    proyectilesEnemigos.add(p);
                }
            }
        }

        /** Actualiza el efecto del luckyblock*/
        for (int i = luckyblock.size() - 1; i >= 0; i--) {
            Lucky lucky = luckyblock.get(i);
            lucky.display(); /** Dibuja el lucky*/
            if (PVector.dist(lucky.posicion, prota.getPosicion()) < 20) { /** Si el protagonista toca el bloque*/
                lucky.aplicarEfecto(prota); /** Aplica el efecto y elimina el bloque*/
                luckyblock.remove(i);
            }
        }

        /** Actualiza el comportamiento de los proyectiles de enemigos respecto del jugador*/
        for (int i = proyectilesEnemigos.size() - 1; i >= 0; i--) {
            Proyectil p = proyectilesEnemigos.get(i);
            p.update(deltaTime); /** mover el proyectil */
            p.display(); /** dibujar el proyectil*/
            /** Colision con el protagonista*/
            if (PVector.dist(p.getPosicion(), prota.getPosicion()) < prota.getRadio() + p.getRadio()) {
                proyectilesEnemigos.remove(i);
                prota.recibirDano(); /** quitar vidas al protagonista*/
                if (prota.getVidas() <= 0) {
                    estadoActual = ESTADO_GAMEOVER; /** GameOver al llegar a vidas=0*/
                    prota.guardarPuntuacion();
                }
            }
            if (p.estaFueraDePantalla()) { /** Si el proyectil esta fuera de pantalla se borra*/
                proyectilesEnemigos.remove(i);
            }
        }
        
       
/** Actualiza el comportamiento de los proyectiles del jugador respecto de enemigos*/
for (Proyectil pJugador : prota.getProyectiles()) {
    for (int i = enemigos.size() - 1; i >= 0; i--) {
        Enemigo e = enemigos.get(i);

        /** Verifica la colision*/
        if (PVector.dist(pJugador.getPosicion(), e.getPosicion()) < e.getRadio() + pJugador.getRadio()) {
            
               /** remueve el enemigo*/
            enemigos.remove(i);
               /** suma 100 puntos*/
            prota.aumentarPuntaje(100);
            
               /** solo en caso de que el modo horda este activo*/
            if (HORDA) {
                prota.ganarVidas();    /** vidas extra*/
                
                   /** generar una cantidad aleatoria de enemigos nuevos 1,3 */
                int cantidad = int(random(1, 4));

                   /** Limite maximo de enemigos en el campo*/
                int limiteMaximo = 100;

                for (int j = 0; j < cantidad; j++) {
                    if (enemigos.size() >= limiteMaximo) break;    /** Generacion de enemigos*/

                       /** Nueva posicion aleatoria del enemigo*/
                    PVector nuevaPosicion = new PVector(random(0, 2400), random(0, 1600));
                    
                       /** Tipo del enemigo que se generará*/
                    int tipo = int(random(4)); 
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
                            enemigos.add(new Enemigo(nuevaPosicion)); 
                            break;
                    }
                }
            }

            break; 
        }
    }
}

        
        
           /** Mensaje flotante para la ui*/
        mensajeFlotante.dibujar();
        mensajeFlotante.actualizar(deltaTime);

          /**Controles dentro del nivel */
        if (joypad.isUpPressed()) prota.mover(0, deltaTime);
        if (joypad.isRightPressed()) prota.mover(1, deltaTime);
        if (joypad.isDownPressed()) prota.mover(2, deltaTime);
        if (joypad.isLeftPressed()) prota.mover(3, deltaTime);

           /** HUD en pantalla*/
        gestorPantallas.mostrarHUD();

           /** CondicionEspecial para poder avanzar al siguiente nivel*/
        if (condicionEspecial != null) {
            condicionEspecial.run();
        }
    }
}

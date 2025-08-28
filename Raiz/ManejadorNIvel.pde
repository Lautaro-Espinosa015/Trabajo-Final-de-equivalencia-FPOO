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

        // Colisiones de proyectiles del jugador con enemigos
        for (Proyectil pJugador : prota.getProyectiles()) {
            for (int i = enemigos.size() - 1; i >= 0; i--) {
                Enemigo e = enemigos.get(i);
                if (PVector.dist(pJugador.getPosicion(), e.getPosicion()) < e.getRadio() + pJugador.getRadio()) {
                    enemigos.remove(i);
                    prota.aumentarPuntaje(100);
                    break;
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

        
    }
}

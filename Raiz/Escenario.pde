class Escenario{

}

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

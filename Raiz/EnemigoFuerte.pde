// Variante de Enemigo: EnemigoFuerte
class EnemigoFuerte extends Enemigo {
  private PImage enemigo2;
    public EnemigoFuerte(PVector posicion,PImage enemigo2) {
        super(posicion);
        this.radio = 30; // Mayor tamaño
        this.colorEnemigo = color(255, 165, 0); // Color naranja
        this.intervaloDisparo = 120; // Dispara más lento
        this.enemigo2 = enemigo2;
    }
    @Override
    protected void disparar(Protagonista prota) {
        // Lógica de disparo diferente, por ejemplo, proyectiles más fuertes
        tiempoDisparo++;
        if (tiempoDisparo >= intervaloDisparo) {
            tiempoDisparo = 0;
            PVector direccion = PVector.sub(prota.getPosicion(), this.posicion);
            direccion.normalize();
            direccion.mult(200); // Proyectiles más lentos
            Proyectil nuevoProyectil = new Proyectil(this.posicion.copy(), color(255, 0, 0), direccion, 20); // Más daño
            proyectiles.add(nuevoProyectil);
        }
    }
    @Override
    public void display() {
        // Dibujar la imagen del enemigo en su posición
        image(enemigo2, posicion.x - enemigo2.width / 2, posicion.y - enemigo2.height / 2); // Centrar la imagen
    }
}

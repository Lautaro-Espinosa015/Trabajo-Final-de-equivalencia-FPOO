/** Clase heredada de enemigo */
class EnemigoFuerte extends Enemigo { 
  private PImage enemigo2;
    public EnemigoFuerte(PVector posicion,PImage enemigo2) { /** contructor */
        super(posicion); /** Se hereda su posicion */
        this.radio = 30; /** Tamaño aumentado*/
        this.colorEnemigo = color(255, 165, 0); /** color de versiones anteriores*/
        this.intervaloDisparo = 120; /** Intervalo de disparo aumentado*/
        this.enemigo2 = enemigo2;
    }
    @Override
    protected void disparar(Protagonista prota) {
        /** Logica particular del disparo del enemigo fuerte*/
        tiempoDisparo++;
        if (tiempoDisparo >= intervaloDisparo) {
            tiempoDisparo = 0;
            PVector direccion = PVector.sub(prota.getPosicion(), this.posicion);
            direccion.normalize(); /** Se convierte en un vector unitario*/
            direccion.mult(200); /** Velocidad del disparo aumentada*/
            Proyectil nuevoProyectil = new Proyectil(this.posicion.copy(), color(255, 0, 0), direccion, 20); /** */
            proyectiles.add(nuevoProyectil); /** */
        }
    }
    @Override
    public void display() {
        /** Metodo alterado para dibujar al enemigo fuerte*/
        image(enemigo2, posicion.x - enemigo2.width / 2, posicion.y - enemigo2.height / 2); 
    }
}

/** Variante de enemigo, enemigo lento*/
class EnemigoLento extends Enemigo {
    private PImage enemigo1;
    public EnemigoLento(PVector posicion,PImage enemigo1) { /** contructor*/
        super(posicion); /** Se hereda la posicion generada*/
        this.velocidad = new PVector(random(1, 2), random(1, 2)); /** velocidad alterada a una más lenta */
        this.colorEnemigo = color(0, 0, 255); /** Color base azul */
        this.enemigo1 = enemigo1;
        this.intervaloDisparo = 190; /** Intervalo de disparo alterado, uno mucho más lento */
    }
    @Override
    public void display() {
        /** Metodo de dibujo alterado con la imagen particular del enemigo lento*/
        image(enemigo1, posicion.x - enemigo1.width / 2, posicion.y - enemigo1.height / 2); 
    }
}

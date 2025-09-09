/** Variante de enemigo enemigo Rapido */
class EnemigoRapido extends Enemigo {
    private PImage enemigo3;
    public EnemigoRapido(PVector posicion, PImage enemigo3) { /** constructor*/
        super(posicion); /** Hereda la posicion de la clase padre */
        this.velocidad = new PVector(random(3, 5), random(3, 5)); /** Velocidad aumentada */
        this.colorEnemigo = color(0, 255, 0); /** Color base distintivo*/
        this.intervaloDisparo = 60; /**Intervalo de disparo más bajo*/
        this.enemigo3 = enemigo3;
    }
    @Override
    public void display() {
        /** Metodo de dibujo alterado con la imagen particular del enemigo rapido*/
        image(enemigo3, posicion.x - enemigo3.width / 2, posicion.y - enemigo3.height / 2); // Centrar la imagen
    }
}

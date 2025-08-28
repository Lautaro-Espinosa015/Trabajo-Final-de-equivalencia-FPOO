// Variante de Enemigo: EnemigoLento
class EnemigoLento extends Enemigo {
    private PImage enemigo1;
    public EnemigoLento(PVector posicion,PImage enemigo1) {
        super(posicion);
        this.velocidad = new PVector(random(1, 2), random(1, 2)); // Menor velocidad
        this.colorEnemigo = color(0, 0, 255); // Color azul
        this.enemigo1 = enemigo1;
        this.intervaloDisparo = 150; // Dispara más lento
    }
    @Override
    public void display() {
        // Dibujar la imagen del enemigo en su posición
        image(enemigo1, posicion.x - enemigo1.width / 2, posicion.y - enemigo1.height / 2); // Centrar la imagen
    }
}

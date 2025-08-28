class EnemigoRapido extends Enemigo {
    private PImage enemigo3;
    public EnemigoRapido(PVector posicion, PImage enemigo3) {
        super(posicion);
        this.velocidad = new PVector(random(3, 5), random(3, 5)); // Mayor velocidad
        this.colorEnemigo = color(0, 255, 0); // Color verde
        this.intervaloDisparo = 60; // Dispara más rápido
        this.enemigo3 = enemigo3;
    }
    @Override
    public void display() {
        // Dibujar la imagen del enemigo en su posición
        image(enemigo3, posicion.x - enemigo3.width / 2, posicion.y - enemigo3.height / 2); // Centrar la imagen
    }
}

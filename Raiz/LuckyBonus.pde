class LuckyBonus extends Lucky {
    private int bonificacion;
    private float duracion;

    public LuckyBonus(PVector posicion, int bonificacion, float duracion) {
        super(posicion, lucky);
        this.bonificacion = bonificacion;
        this.duracion = duracion;
    }

    @Override
    public void aplicarEfecto(Protagonista prota) {
        prota.aumentarPuntaje(bonificacion);
        int bonus = (int) random(3);
        if (bonus == 0) {
            prota.setDobleDisparo();
            mostrarMensaje("¡Doble Disparo!", 3.0f, color(0, 255, 0));
        } else if (bonus == 1) {
            prota.setInvulnerable(duracion); // Otorgar invulnerabilidad
            mostrarMensaje("¡Eres invulnerable por " + duracion + " segundos!", 3.0f, color(0, 255, 0));
        }
        else if (bonus == 2){
            prota.aumentarPuntaje(1000);
            mostrarMensaje("¡Eres Increible tu puntuacion es de ", 3.0f, color(0, 255, 0));
        }
    }

    @Override
    public void display() {
        fill(0, 255, 0);
        super.display();
    }
}

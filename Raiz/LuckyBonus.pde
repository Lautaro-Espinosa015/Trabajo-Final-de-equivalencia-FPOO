class LuckyBonus extends Lucky {
    private int bonificacion; /** numero de puntaje aleatorio aumentado al protagonista */
    private float duracion; /** Duracion de efectos*/

    public LuckyBonus(PVector posicion, int bonificacion, float duracion) { /** Constructor*/
        super(posicion, lucky);
        this.bonificacion = bonificacion; 
        this.duracion = duracion;
    }

    @Override
    public void aplicarEfecto(Protagonista prota) {
        prota.aumentarPuntaje(bonificacion); /** Aumento en puntaje*/
        int bonus = (int) random(3); /** Numero aleatorio para determinar la bonificacion a usar*/
        if (bonus == 0) {
            prota.setDobleDisparo(); /** Bonificacion de doble disparo del protagonista*/
            mostrarMensaje("¡Doble Disparo!", 3.0f, color(0, 255, 0)); /** Mensaje de bonus */
        } else if (bonus == 1) {
            prota.setInvulnerable(duracion); /**Bonificacion de invulnerabilidad y duracion de la misma*/
            mostrarMensaje("¡Eres invulnerable por " + duracion + " segundos!", 3.0f, color(0, 255, 0)); /** Mensaje de bonus */
        }
        else if (bonus == 2){
            prota.aumentarPuntaje(1000); /** Aumento drastico de puntaje */
            mostrarMensaje("¡Eres Increible tu puntuacion es de " + prota.getScore() + " ", 3.0f, color(0, 255, 0)); /** Mensaje de bonus con la nueva puntuacion */
        }
    }

    @Override
    public void display() { /** Metodo de dibujo*/
        fill(0, 255, 0);
        super.display();
    }
}

class LuckyPenalty extends Lucky {
  private int penalizacion;
  private float duracion;
  
  public LuckyPenalty(PVector posicion, int penalizacion, float duracion){
    super (posicion,lucky);
    this.penalizacion = penalizacion;
     this.duracion = duracion;
  }
  
  @Override
    public void aplicarEfecto(Protagonista prota) {
        prota.reducirPuntaje(penalizacion); // Método que debes implementar en Protagonista
        int debuff = (int) random (3);
        if (debuff == 0){
          prota.setDisparoFalse(duracion); // Reducir velocidad
          prota.setDobleDisparoOFF();
          mostrarMensaje("¡Sin disparos!", 3.0f, color(0, 255, 0));
        }
        if (debuff == 1){
          prota.reducirPuntaje(2000);
          mostrarMensaje("Hemos reducido tu puntaje para alargar el juego artificialmente ", 3.0f, color(0, 255, 0));
        }
        if (debuff == 2){
            int cantidadEnemigos = (int) random(1, 6); // Generar una cantidad aleatoria de enemigos (1 a 5)
            agregarEnemigos(cantidadEnemigos); 
            mostrarMensaje("Duplicaquemos los enemigos, estaba muy facil!!", 3.0f, color(0, 255, 0));
        }
    }
    @Override
    public void display() {
        fill(255, 0, 0); // Color rojo para penalizaciones
        super.display();
    }
  
}

class LuckyPenalty extends Lucky {
  private int penalizacion;  /** Numero en el que el puntaje del protagonista puede reducirse*/
  private float duracion;  /** duracion de la penlizacion*/
  
  public LuckyPenalty(PVector posicion, int penalizacion, float duracion){ /** Constructor*/
    super (posicion,lucky);
    this.penalizacion = penalizacion;
     this.duracion = duracion;
  }
  
  @Override
    public void aplicarEfecto(Protagonista prota) {
        prota.reducirPuntaje(penalizacion);  /** Reduccion de puntaje */
        int debuff = (int) random (3);  /** */
        if (debuff == 0){
          prota.setDisparoFalse(duracion);  /** Apaga la funcion de disparo del protagonista */ 
          prota.setDobleDisparoOFF();  /** Apagar doble disparo*/
          mostrarMensaje("¡Sin disparos!", 3.0f, color(0, 255, 0)); /** Mensaje de penalizacion */ 
        }
        if (debuff == 1){
          prota.reducirPuntaje(2000); /** Reduccion de puntaje drastica*/ 
          mostrarMensaje("Hemos reducido tu puntaje para alargar el juego artificialmente ", 3.0f, color(0, 255, 0)); /** Mensaje de penalizacion */ 
        }
        if (debuff == 2){
            int cantidadEnemigos = (int) random(1, 12); /** Aumenta la cantidad de enemigos aleatoriamente entre 1 y 12 */ 
            agregarEnemigos(cantidadEnemigos);  /** Llamado a la funcion de raiz, agregar enemigos */ 
            mostrarMensaje("aumente la cantidad enemigos, estaba muy facil!!", 3.0f, color(0, 255, 0)); /** Mensaje de penalizacion*/ 
        }
    }
    @Override
    public void display() {
        fill(255, 0, 0); /** Dibujo del cofre*/ 
        super.display();
    }
  
}

// Atributos
class Enemigo {
  /** Atributos de la clase enemigo, tipo protected para poder ser modificados segun el tipo de enemigo que se herede */
    protected PVector posicion;          /** */
    protected PVector velocidad;         /** */
    protected float radio = 20;          /** */
    protected ArrayList<Proyectil> proyectiles; /** */
    protected int tiempoDisparo = 0;     /** */
    protected int intervaloDisparo = 90; /** */
    protected color colorEnemigo;        /** */


/** */
  public Enemigo(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = new PVector(random(60), random(60)); //modificar velocidad
        this.radio = 20;
        this.proyectiles = new ArrayList<Proyectil>();
        this.colorEnemigo = color(255,0,0);
   }
  
  /** funcion para dibujar al enemigo base*/
  public void display(){
  fill(colorEnemigo);
  strokeWeight(5);
  for (Proyectil p : proyectiles) {
            p.display();
    }
  }
  /** funcion para actualizar a cada enemigo del campo en movimiento y disparo*/
  public void update (Protagonista prota, float deltaTime){
    mover(deltaTime);
    disparar(prota);
    actualizarProyectiles();
  }
  
  /** logica del moviimiento y colisiones con el borde del mapa */ 
  public void mover(float deltaTime) {   
      this.posicion.add(PVector.mult(this.velocidad, deltaTime)); /** logica del moviimiento y colisiones con el borde del mapa Ajustado por deltaTime */ 
      /** verifica si el enemigo se encuentra en los bordes y lo hace rebotar como el logo de dvd*/
      if (this.posicion.x < 0) {
          this.posicion.x = 0; 
          this.velocidad.x *= -1; 
      }
      if (this.posicion.x > 2400) {
          this.posicion.x = 2400; 
          this.velocidad.x *= -1; 
      }
      if (this.posicion.y < 0) {
          this.posicion.y = 0; 
          this.velocidad.y *= -1; 
      }
      if (this.posicion.y > 1600) {
          this.posicion.y = 1600; 
          this.velocidad.y *= -1; 
      }
    }
    
    // El enemigo dispara al protagonista
  protected void disparar (Protagonista prota){
    tiempoDisparo++;
    if(tiempoDisparo >= intervaloDisparo){
      tiempoDisparo = 0;
      PVector direccion = PVector.sub(prota.getPosicion(), this.posicion);
      direccion.normalize();
      direccion.mult(100);
      
      Proyectil nuevoProyectil = new Proyectil(this.posicion.copy(), color(0, 0, 255), direccion, 10);
      proyectiles.add(nuevoProyectil);
    }
  }
  
  // Recarga de proyectiles/eliminar proyectiles fuera del mapa
  protected void actualizarProyectiles() {
    for (int i = proyectiles.size() -1;i>=0;i--){
      Proyectil p = proyectiles.get(i);
      
      if(p.estaFueraDePantalla()){
        proyectiles.remove(i);
      }
    }
  }
  public ArrayList<Proyectil> getProyectiles() {
        return this.proyectiles;
    }
   public PVector getPosicion() {
        return this.posicion;
    }
    

    public float getRadio() {
        return this.radio;
    }  
}

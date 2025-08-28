// Atributos
class Enemigo {
    protected PVector posicion;          // Cambiado a protected
    protected PVector velocidad;         // Cambiado a protected
    protected float radio = 20;          // Cambiado a protected
    protected ArrayList<Proyectil> proyectiles; // Cambiado a protected
    protected int tiempoDisparo = 0;     // Cambiado a protected
    protected int intervaloDisparo = 90; // Cambiado a protected
    protected color colorEnemigo;        // Cambiado a protected



  public Enemigo(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = new PVector(random(60), random(60)); //modificar velocidad
        this.radio = 20;
        this.proyectiles = new ArrayList<Proyectil>();
        this.colorEnemigo = color(255,0,0);
   }
  
  // dibujar  
  public void display(){
  fill(colorEnemigo);
  strokeWeight(5);
  for (Proyectil p : proyectiles) {
            p.display();
    }
  }
  // actualizar
  public void update (Protagonista prota, float deltaTime){
    mover(deltaTime);
    disparar(prota);
    actualizarProyectiles();
  }
  
  // logica del moviimiento y colisiones con el borde del mapa
  public void mover(float deltaTime) {
      // Mueve el enemigo según su velocidad
      this.posicion.add(PVector.mult(this.velocidad, deltaTime)); // Ajustar la velocidad por deltaTime
      // Verifica si el enemigo se sale de los bordes y rebota
      if (this.posicion.x < 0) {
          this.posicion.x = 0; // Asegúrate de que no se salga
          this.velocidad.x *= -1; // Invertir dirección en x
      }
      if (this.posicion.x > 2400) {
          this.posicion.x = 2400; // Asegúrate de que no se salga
          this.velocidad.x *= -1; // Invertir dirección en x
      }
      if (this.posicion.y < 0) {
          this.posicion.y = 0; // Asegúrate de que no se salga
          this.velocidad.y *= -1; // Invertir dirección en y
      }
      if (this.posicion.y > 1600) {
          this.posicion.y = 1600; // Asegúrate de que no se salga
          this.velocidad.y *= -1; // Invertir dirección en y
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

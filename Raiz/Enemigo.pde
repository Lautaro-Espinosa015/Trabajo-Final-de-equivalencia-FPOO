// Atributos
class Enemigo {
  /** Atributos de la clase enemigo, tipo protected para poder ser modificados segun el tipo de enemigo que se herede */
    protected PVector posicion;          /** Posicion generada del enemigo*/
    protected PVector velocidad;         /** Velocidad base del enemigo*/
    protected float radio = 20;          /** Tamaño base del enemigo*/
    protected ArrayList<Proyectil> proyectiles; /** Array de proyectiles propio*/
    protected int tiempoDisparo = 0;     /** Tiempo entre disparos*/
    protected int intervaloDisparo = 90; /** Intervalo base de disparo*/
    protected color colorEnemigo;        /** Color base del enemigo*/


/** Constructor */
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
    
    /** Logica para el disparo del enemigo*/
  protected void disparar (Protagonista prota){
    tiempoDisparo++;
    if(tiempoDisparo >= intervaloDisparo){ /** Se crea un cooldown para que los disparon no se acumulen demasiado entre si, para tener espacio entre disparos*/
      tiempoDisparo = 0;
      PVector direccion = PVector.sub(prota.getPosicion(), this.posicion);
      direccion.normalize();
      direccion.mult(100);
      
      Proyectil nuevoProyectil = new Proyectil(this.posicion.copy(), color(0, 0, 255), direccion, 10); /** se agrega el proyectil al array*/
      proyectiles.add(nuevoProyectil);
    }
  }
  
  // Recarga de proyectiles/eliminar proyectiles fuera del mapa
  protected void actualizarProyectiles() { /** Funcion eliminar proyectiles fuera del mapa para no recargar el videojuego*/
    for (int i = proyectiles.size() -1;i>=0;i--){
      Proyectil p = proyectiles.get(i);
      
      if(p.estaFueraDePantalla()){
        proyectiles.remove(i);
      }
    }
  }
  public ArrayList<Proyectil> getProyectiles() { /** Metodos accesores*/
        return this.proyectiles;
    }
   public PVector getPosicion() {
        return this.posicion;
    }
    

    public float getRadio() {
        return this.radio;
    }  
}

class Proyectil {
  private PVector posicion; /** posicion del proyectil*/
  private PVector velocidad; /** velocidad del proyectil*/
  private float radio; /** Tamaño del proyectil*/
  private color colorProyectil; /** Color del proyectul*/
  private float dmg; /** Daño*/
  
  /** Constructores */
  
  Proyectil (PVector posicion,color c,PVector velocidad, float dmg){
    this.posicion = posicion.copy();
    this.velocidad = velocidad.copy();
    this.radio = 5;
    this.colorProyectil = c;
    this.dmg = dmg;
  }
  
  /** */
  
  /** actualizacion de velocidad y posicion del proyectil*/
  void update(float deltaTime){
   posicion.add(PVector.mult(velocidad, deltaTime));
  }
  /** dibujado del proyectil*/
  void display(){
    fill(colorProyectil);
    noStroke();
    circle(posicion.x,posicion.y,radio*2);
  }
  /** borrado del proyectil al salir del lienzo*/
  boolean estaFueraDePantalla(){
    return posicion.x < -2400 || posicion.x > width +2400 || posicion.y < -2400 || posicion.y > height +2400;
  }
  /** metodos accesores */
   public PVector getPosicion() {
        return this.posicion.copy();
    }
    public float getRadio() {
        return this.radio;
    }
 
    
    
    

}
    
    

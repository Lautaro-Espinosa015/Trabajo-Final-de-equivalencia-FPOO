class Proyectil {
  private PVector posicion;
  private PVector velocidad;
  private float radio;
  private color colorProyectil;
  private float dmg;
  
  Proyectil (PVector posicion,color c,PVector velocidad, float dmg){
    this.posicion = posicion.copy();
    this.velocidad = velocidad.copy();
    this.radio = 5;
    this.colorProyectil = c;
    this.dmg = dmg;
  }
  
  void update(float deltaTime){
   posicion.add(PVector.mult(velocidad, deltaTime));
  }
  
  void display(){
    fill(colorProyectil);
    noStroke();
    circle(posicion.x,posicion.y,radio*2);
  }
  
  boolean estaFueraDePantalla(){
    return posicion.x < -2400 || posicion.x > width +2400 || posicion.y < -2400 || posicion.y > height +2400;
  }
  
   public PVector getPosicion() {
        return this.posicion.copy();
    }
    public float getRadio() {
        return this.radio;
    }
 
    
    
    

}
    
    

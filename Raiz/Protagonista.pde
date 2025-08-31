// Atributos
class Protagonista {
private PVector posicion; /** Atributo para la posicon*/
private PVector velocidad; /** Atributo para la velocidad*/
private ArrayList<Proyectil> proyectiles; /** Array para la gestion de proyectiles*/
private int vidas = 500; /** Cantidad de vidas del protagonista*/
private float radio = 20; /** Hitbox del protagonista*/
private int score = 0; /** Puntuacion del protagonista a lo largo del juego*/
private float tiempoEntreDisparos = 0.25f; /** coldown entre disparos*/
private float tiempoUltimoDisparo = 0; /** Temporarizador de disparos */
private boolean puedeDisparar = true;
 private boolean invulnerable = false;
private float tiempoInvulnerable = 0;
private PImage protagonista; /** textura del protagonista*/
private boolean DobleDisparo = false;
private float tiempoSinDisparo= 0 ;

   public Protagonista() { /** metodos accesores*/
        this.posicion = new PVector(width/2, height/2);
        this.velocidad = new PVector(5, 5);
        this.proyectiles = new ArrayList<Proyectil>();
        this.protagonista = protagonista;
  }
  
/** */
    
  /** funcion para dibujar al protagonista + dibujo del proyectil al invocarse*/
  public void display(PImage protagonista){
  fill(255,0,0);
  strokeWeight(5);
  // circle(this.posicion.x,this.posicion.y,40);
  image(protagonista,posicion.x - protagonista.width/2,posicion.y-protagonista.height/2);
  for (Proyectil p : proyectiles){
    p.display();
    }
  }

/** logica del moviimiento y colisiones con el borde del mapa */ 
  public void mover(int direccion, float deltaTime) {
        float velocidadActual = 300 * deltaTime;
        
        switch(direccion) {
        case 0: /**Arriba */ 
            this.posicion.y -= velocidadActual;
            if (this.posicion.y < 0) this.posicion.y = 0;
            break;  
        case 1: /** Derecha*/ 
            this.posicion.x += velocidadActual;
            if (this.posicion.x > 2400) this.posicion.x = 2400;
            break;
        case 2: /**Abajo */ 
            this.posicion.y += velocidadActual;
            if (this.posicion.y > 1600) this.posicion.y = 1600;
            break;  
        case 3: /** Izquierda*/ 
            this.posicion.x -= velocidadActual;
            if (this.posicion.x < 0) this.posicion.x = 0;
            break;
      }
    }
    
    /** */
    
    /** Logica de disparo del protagonista + limitacion de balas */ 
        public void disparar() {
     if (tiempoSinDisparo == 0){
    if (puedeDisparar) {
        PVector direccion = new PVector(0, -1);  /** Genera un PVector direccion con una Dirección fija hacia arriba (eje Y negativo) */
        direccion.mult(500);  /** Velocidad del proyectil (500 píxeles/segundo) */
        
        Proyectil nuevoProyectil = new Proyectil( /** Objeto proyectil con los parametros de posicion color, direccion y daño*/
            new PVector(posicion.x, posicion.y - radio),  
            color(0, 255, 0),   /**  Color verde para distinguirlas */
            direccion, 
            1   /** Daño del proyectil */ 
        );
        proyectiles.add(nuevoProyectil);
        puedeDisparar = false; /** Activacion del coldown*/
        tiempoUltimoDisparo = 0;  /** Reiniciar el temporizador entre disparos */  
    }
    
    if (DobleDisparo){
        float angulo = random(TWO_PI); // Generar un ángulo aleatorio
        PVector direccion = new PVector(cos(angulo), sin(angulo)); // Convertir a vector de dirección
        direccion.mult(500);  // Velocidad del proyectil (500 píxeles/segundo)
        
        Proyectil nuevoProyectil = new Proyectil(
            new PVector(posicion.x, posicion.y - radio),  // Posición inicial ajustada
            color(255, 255, 0),  // Color verde para distinguirlas
            direccion, 
            1  // Daño del proyectil
        );
        proyectiles.add(nuevoProyectil);
        puedeDisparar = false;
        tiempoUltimoDisparo = 0;  // Reiniciar el temporizador
      
    }
    
    
}
        }
    
   public void update(float deltaTime) { /** Logicas de actualizacion del protagonista */
    // Actualizar temporizador de disparo
    if (invulnerable) {
      tiempoInvulnerable -= deltaTime;
      if (tiempoInvulnerable <= 0){
        invulnerable = false;
      }
    }
         /** Actualizar temporizador de disparo */
        if (!puedeDisparar) {
            tiempoUltimoDisparo += deltaTime;
            if (tiempoUltimoDisparo >= tiempoEntreDisparos) {  /** El tiempo entre disparos lo delimita los frames ya pasados (para que no sea como "un laser"*/
                puedeDisparar = true;  /** Permitir disparar de nuevo  */
                tiempoUltimoDisparo = 0;  /**Reiniciar el temporizador */
            }
        }
        /** Actualizar el tiempo sin disparo */ 
        if (tiempoSinDisparo > 0) {
            tiempoSinDisparo -= deltaTime;
            if (tiempoSinDisparo <= 0) {
                puedeDisparar = true; 
                tiempoSinDisparo = 0; 
            }
    }
    
    /** borrado de proyectiles que se salen de la pantalla  */ 
    for (int i = proyectiles.size() - 1; i >= 0; i--) {
        Proyectil p = proyectiles.get(i);
        p.update(deltaTime);
        if (p.estaFueraDePantalla()) {
            proyectiles.remove(i);
        }
    }
}
      
    /** Funcion para restar vidas del protagonista*/
   public void recibirDano() {
    if (!invulnerable) { /** Solo reduce vidas si no está invulnerable */ 
        vidas--;
    }
    
   }
   
   /** Funcion de ganar vidas SOLO EN MODO HORDA */
   public void ganarVidas(){
     if (vidas < 1200){  /** Limite de vidas*/
     vidas+=5;
     }      
   }
   
   /** Metodos accesores */
   
   public void aumentarVelocidad(float incremento){ //no se usa
     this.velocidad.add(new PVector (incremento,incremento));
   }
   
   public void reducirVelocidad (float decremento){ //no se usa
     this.velocidad.add(new PVector (decremento,decremento));
     this.velocidad.limit(0);
   }
   
   
   public void setInvulnerable (float duracion){
     this.invulnerable = true;
     this.tiempoInvulnerable = duracion;
   }
   public void setDisparoFalse ( float duracion){
     this.puedeDisparar = false;
     this.tiempoSinDisparo = duracion;
   }
   
   public void setDobleDisparoOFF(){
    this.DobleDisparo = false;
}

  public void setPosicion(PVector posicion){
    this.posicion= posicion;
  
  }
  public void setVelocidad(PVector velocidad){
    this.velocidad= velocidad;
  
  }
  
  public int getScore(){
return this.score;
}
  
   public void cargarPuntuacion() { //no se usa
    String[] datos = loadStrings("puntuacion.txt"); 
    if (datos.length > 0) {
        score = Integer.parseInt(datos[0]); 
    }
}
  
  public void guardarPuntuacion() { //no se usa
    String[] datos = {String.valueOf(score)}; 
    saveStrings("puntuacion.txt", datos); 
}
 
  public ArrayList<Proyectil> getProyectiles() {
    return proyectiles;
}
public int getVidas() {
    return vidas;
}

public void setDobleDisparo(){
    this.DobleDisparo = true;
   
}

// En la clase Proyectil:
public PVector getPosicion() {
    return posicion;
}
public float getRadio() {
    return radio;
}

/** Logica de puntuacion */

public void aumentarPuntaje(int cantidad) {
    score += cantidad; // Aumentar el puntaje
    println("score actual del prota: "+ score) ;
}
public void reducirPuntaje(int cantidad) {
    score -= cantidad; // Reducir el puntaje
    println("score actual del prota: "+ score) ;
}






}

class Lucky {
    private PVector posicion; /** Posicion del cofre */
    private PImage lucky;/** Imagen del cofre*/

    
    public Lucky() { 
        this.posicion = new PVector(0, 0); 
    }

    public Lucky(PVector posicion, PImage lucky) {  /** Constructor */
        this.posicion = posicion;
        this.lucky = lucky;
    }

    public void display() { /** Dibujo del cofre en pantalla */
        image(lucky,posicion.x,posicion.y);
    }
    
    public void aplicarEfecto (Protagonista Prota){ /** Metodo general para aplicar el efecto*/
      
    }
}

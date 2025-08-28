class Lucky {
    private PVector posicion;
    private PImage lucky;

    
    public Lucky() {
        this.posicion = new PVector(0, 0); 
    }

    public Lucky(PVector posicion, PImage lucky) {
        this.posicion = posicion;
        this.lucky = lucky;
    }

    public void display() {
        image(lucky,posicion.x,posicion.y);
    }
    
    public void aplicarEfecto (Protagonista Prota){
      
    }
}

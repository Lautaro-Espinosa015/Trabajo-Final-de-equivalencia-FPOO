class MensajeFlotante {
    private String texto; /** Atributo del cadena de texto*/
    private float tiempoRestante; /** Atributo del tiempo del msj*/
    private PFont fuente; /** atributo de la fuente*/
    private int colorTexto; /** atributo del color del texto*/
  
    public MensajeFlotante(PFont fuente) { /** constructor*/
        this.fuente = fuente; 
        this.texto = "";
        this.tiempoRestante = 0;
        this.colorTexto = color(250, 250, 250); 
    }
  
    public void mostrar(String mensaje, float duracion, int colores) {  /** constructor*/
        this.texto = mensaje;
        this.tiempoRestante = duracion;
        this.colorTexto = colores;
    }
  
    public void actualizar(float deltaTime) { /** metodo para establecer el tiempo del mensaje*/
        if (tiempoRestante > 0) {
            tiempoRestante -= deltaTime;
        }
    }
  
    public void dibujar() { /** metodo para dibujar el mensaje*/
        if (tiempoRestante > 0) {
            pushMatrix();
            resetMatrix(); 
            fill(colorTexto);
            textFont(fuente);
            textAlign(CENTER, CENTER);
            text(texto, width / 2, 50); 
            popMatrix();
        }
    }
}

class MensajeFlotante {
    private String texto;
    private float tiempoRestante;
    private PFont fuente;
    private int colorTexto;
  
    public MensajeFlotante(PFont fuente) {
        this.fuente = fuente; // Usar la fuente pasada como parámetro
        this.texto = "";
        this.tiempoRestante = 0;
        this.colorTexto = color(255, 255, 255); // Blanco por defecto
    }
  
    public void mostrar(String mensaje, float duracion, int colores) {
        this.texto = mensaje;
        this.tiempoRestante = duracion;
        this.colorTexto = colores;
    }
  
    public void actualizar(float deltaTime) {
        if (tiempoRestante > 0) {
            tiempoRestante -= deltaTime;
        }
    }
  
    public void dibujar() {
        if (tiempoRestante > 0) {
            pushMatrix();
            resetMatrix(); // Importante: resetear transformaciones
            fill(colorTexto);
            textFont(fuente);
            textAlign(CENTER, CENTER);
            text(texto, width / 2, height / 2); // Siempre en centro de pantalla
            popMatrix();
        }
    }
}

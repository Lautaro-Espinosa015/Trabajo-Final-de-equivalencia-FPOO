class GestorPantallas {
  
  PFont fontTitulo, fontTexto;
  ArrayList<Integer> mejoresPuntuaciones;
  float volumen;
  boolean musicaActiva;
  Protagonista prota;

  GestorPantallas(PFont fontTitulo, PFont fontTexto, ArrayList<Integer> mejoresPuntuaciones,
                  float volumen, boolean musicaActiva, Protagonista prota) {
    this.fontTitulo = fontTitulo;
    this.fontTexto = fontTexto;
    this.mejoresPuntuaciones = mejoresPuntuaciones;
    this.volumen = volumen;
    this.musicaActiva = musicaActiva;
    this.prota = prota;
  }

  void dibujarMenu() {
    background(40);
    fill(255, 215, 0);
    textFont(fontTitulo);
    textAlign(CENTER, CENTER);
    text("SPACE SHOOTER", width / 2, 100);

    // Botones volumen
    fill(255);
    rect(width-200, 50, 30, 30);
    rect(width-150, 50, 30, 30);
    rect(width-100, 50, 60, 30);
    text("Volumen: " + int(volumen*100) + "%", width-200, 40);
    text("-", width-195, 70);
    text("+", width-145, 70);
    text(musicaActiva ? "Mute" : "Unmute", width-95, 70);

    // Puntuaciones
    fill(200);
    textFont(fontTexto);
    textAlign(CENTER);
    text("MEJORES PUNTUACIONES", width / 2, 180);
    fill(255);
    for (int i = 0; i < min(5, mejoresPuntuaciones.size()); i++) {
      text((i + 1) + ". " + mejoresPuntuaciones.get(i), width / 2, 230 + i * 40);
    }

    // Botones
    fill(0, 255, 0);
    rect(width / 2 - 100, 450, 200, 60, 10);
    fill(0);
    text("INICIAR JUEGO", width / 2, 480);

    fill(255, 0, 0);
    rect(width / 2 - 100, 530, 200, 60, 10);
    fill(0);
    text("SALIR", width / 2, 560);
  }

  void mostrarPausa() {
    fill(0, 150);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(48);
    text("PAUSA", width / 2, height / 2 - 40);
    textSize(24);
    text("Presiona 'P' para reanudar", width / 2, height / 2 + 10);

    // Botón mute/unmute
    fill(255);
    rect(width/2 - 100, height/2 + 60, 200, 40);
    fill(0);
    text("Mute/Unmute [M]", width/2 - 80, height/2 + 85);
  }

  void mostrarGameOver() {
    background(0);
    fill(255);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width / 2, height / 2);
    textSize(30);
    text("Score: " + prota.getScore(), width / 2, height / 2 + 60);
    text("Presiona 'R' para reiniciar", width / 2, height / 2 + 100);
  }

  void mostrarHUD() {
    pushMatrix();
    resetMatrix();
    fill(255);
    textSize(24);
    textAlign(LEFT);
    text("Vidas: " + prota.getVidas(), 20, 40);
    text("Score: " + prota.getScore(), 20, 70);
    popMatrix();
  }

  void mostrarNivel2() {
    background(0);
    fill(255);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("¡Felicidades! Has alcanzado el Nivel 2", width / 2, height / 2 - 40);
    textSize(30);
    text("Haz click aqui para continuar", width / 2, height / 2 + 20);
  }
}

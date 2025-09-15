class GestorPantallas {
  
  PFont fontTitulo, fontTexto; /** Fuentes del gestor de pantallas*/
  ArrayList<Integer> mejoresPuntuaciones;
  float volumen;
  boolean musicaActiva;
  Protagonista prota; /** objeto protagonista*/

  GestorPantallas(PFont fontTitulo, PFont fontTexto, ArrayList<Integer> mejoresPuntuaciones, /** Constructor*/
                  float volumen, boolean musicaActiva, Protagonista prota) {
    this.fontTitulo = fontTitulo;
    this.fontTexto = fontTexto;
    this.mejoresPuntuaciones = mejoresPuntuaciones;
    this.volumen = volumen;
    this.musicaActiva = musicaActiva;
    this.prota = prota;
  }

  /** */
  /** Menu Principal*/
  void dibujarMenu() {
  background(40);
  // ====== TÍTULO ======
  fill(255, 215, 0);   /**Color dorado */
  textFont(fontTitulo);   /**Usar fuente del título */
  textAlign(CENTER, CENTER);  /**Alinear texto al centro */
  text("Magic Dungeon", width / 2, 100); /**Título principal en la parte superior */
  
  
  // ====== MEJORES PUNTUACIONES ======   /** quitar */
  fill(200); // Color gris claro para el título
  textFont(fontTexto); // Fuente normal
  textAlign(CENTER);
  text("CONTROLES:", width / 2, 160);
  text("W/A/S/D - Movimiento", width / 2, 190);
  text("ESPACIO - Disparar", width / 2, 220);
  text("P - Pausa", width / 2, 250);
  text("ESC - Cerrar aplicación", width / 2, 280);
  text("M - Mutear música", width / 2, 310);

  
  fill(255); // Color blanco para las puntuaciones
  for (int i = 0; i < min(5, mejoresPuntuaciones.size()); i++) {
    text((i + 1) + ". " + mejoresPuntuaciones.get(i), width / 2, 250 + i * 40);
  }
  
   /** ====== BOTÓN INICIAR JUEGO ====== */ 
  fill(0, 255, 0); /** verde */
  rect(width / 2 - 150, 500, 300, 70, 15);
  fill(0); /** texto negro */
  text("INICIAR JUEGO", width / 2, 535);
  
   /** ====== BOTÓN Modo Horda ====== */ 
  fill(0, 150, 255); /** azul */
  rect(width / 2 - 150, 600, 300, 70, 15);
  fill(255); /** texto blanco */
  text("MODO HORDA", width / 2, 635);
  
   /** ====== BOTÓN SALIR ====== */
  fill(255, 0, 0); /** rojo */
  rect(width / 2 - 150, 700, 300, 70, 15);
  fill(0); /** texto negro */
  text("SALIR", width / 2, 735);
}

  /** ====== Modo pausa ====== */
  void mostrarPausa() {
    fill(0, 150);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(48);
    text("PAUSA", width / 2, height / 2 - 40);
    textSize(24);
    text("Presiona 'P' para reanudar", width / 2, height / 2 + 10);

    /** Botón mute/unmute */   
    fill(255);
    rect(width/2 - 110, height/2 + 80, 220, 50, 8);
    fill(0);
    textAlign(CENTER, CENTER);
    text("Mute/Unmute [M]", width/2, height/2 + 105);
  }
  /** ====== Modo Gameover ====== */
  void mostrarGameOver() {
    background(0);
    fill(255);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width / 2, height / 2);
    textSize(30);
    text("Score: " + prota.getScore(), width / 2, height / 2 + 60);
    text("Presiona 'R' para reiniciar", width / 2, height / 2 + 100);
    text("Presiona 'E' para Volver al menu", width / 2, height / 2 + 150);
  }
  /** ====== HUD in-game ====== */
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
  /** ====== Pantalla nivel 2 ====== */
  void mostrarNivel2() {
    background(0);
    fill(255);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("¡Felicidades! Has alcanzado el Nivel 2", width / 2, height / 2 - 40);
    textSize(30);
    text("Presiona n para continuar", width / 2, height / 2 + 20);
  }
  /** ====== Pantalla de fin de juego ====== */
  void mostrarGameEnd() {
    background(0);
    fill(255);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("Haz finalizado la DEMO!!!", width / 2, height / 2);
    textSize(30);
    text("Tu Score: " + prota.getScore()+ " Grandioso!!!", width / 2, height / 2 + 60);
    text("Presiona 'R' para volver al menu", width / 2, height / 2 + 100);
  }
  
}

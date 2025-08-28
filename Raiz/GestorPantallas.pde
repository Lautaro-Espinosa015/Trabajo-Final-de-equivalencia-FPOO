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
  // Fondo gris oscuro del menú
  background(40);
  
  // ====== TÍTULO ======
  fill(255, 215, 0); // Color dorado
  textFont(fontTitulo); // Usar fuente del título
  textAlign(CENTER, CENTER); // Alinear texto al centro
  text("SPACE SHOOTER", width / 2, 100); // Título principal en la parte superior
  
        // ====== CONTROLES DE VOLUMEN ======
    fill(255); // Color blanco para los botones y texto
    
    // Texto de porcentaje de volumen
    textAlign(LEFT, CENTER);
    text("Volumen: " + int(volumen * 100) + "%", width - 450, 70);
    
    // Botón volumen - (disminuir) → más abajo y más separado
    rect(width - 380, 100, 50, 50, 8);
    
    // Botón volumen + (aumentar) → más abajo y más separado
    rect(width - 290, 100, 50, 50, 8);
    
    // Botón mute/unmute → lo dejamos alineado a la nueva altura
    rect(width - 180, 100, 120, 50, 8);
  
  // ====== MEJORES PUNTUACIONES ======
  fill(200); // Color gris claro para el título
  textFont(fontTexto); // Fuente normal
  textAlign(CENTER);
  text("MEJORES PUNTUACIONES", width / 2, 200);
  
  fill(255); // Color blanco para las puntuaciones
  for (int i = 0; i < min(5, mejoresPuntuaciones.size()); i++) {
    text((i + 1) + ". " + mejoresPuntuaciones.get(i), width / 2, 250 + i * 40);
  }
  
  // ====== BOTÓN INICIAR JUEGO ======
  fill(0, 255, 0); // Verde
  rect(width / 2 - 150, 500, 300, 70, 15);
  fill(0); // Texto negro
  text("INICIAR JUEGO", width / 2, 535);
  
  // ====== BOTÓN MODO HORDA ======
  fill(0, 150, 255); // Azul
  rect(width / 2 - 150, 600, 300, 70, 15);
  fill(255); // Texto blanco
  text("MODO HORDA", width / 2, 635);
  
  // ====== BOTÓN SALIR ======
  fill(255, 0, 0); // Rojo
  rect(width / 2 - 150, 700, 300, 70, 15);
  fill(0); // Texto negro
  text("SALIR", width / 2, 735);
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

        // Botón mute/unmute centrado con más espacio vertical
    fill(255);
    rect(width/2 - 110, height/2 + 80, 220, 50, 8);
    
    fill(0);
    textAlign(CENTER, CENTER);
    text("Mute/Unmute [M]", width/2, height/2 + 105);
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
    text("Presiona n para continuar", width / 2, height / 2 + 20);
  }
  
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

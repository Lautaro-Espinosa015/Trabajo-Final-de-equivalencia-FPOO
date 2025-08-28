class GestorAudio {
  Minim minim;
  AudioPlayer musicaMenu;
  AudioPlayer musicaJugando;
  AudioPlayer musicaNivel2;
  float volumen = 0.7;
  boolean muteado = false;
  int estadoActual = -1; // Para controlar cambios
  GestorAudio(PApplet app) {
    minim = new Minim(app);
    musicaMenu = minim.loadFile("menu.wav");
    musicaJugando = minim.loadFile("nivel1.mp3");
    musicaNivel2 = minim.loadFile("nivel2.wav");
    setVolumen(volumen);
  }
  
  void actualizar(int nuevoEstado) {
    if (estadoActual == nuevoEstado) return;
    
    // Detener música anterior
    switch(estadoActual) {
      case ESTADO_MENU: musicaMenu.pause(); break;
      case ESTADO_JUGANDO: musicaJugando.pause(); break;
      case ESTADO_NIVEL2: musicaNivel2.pause(); break;
    }
    
    // Iniciar nueva música
    if (!muteado) {
      switch(nuevoEstado) {
        case ESTADO_MENU:
          musicaMenu.rewind();
          musicaMenu.loop();
          break;
        case ESTADO_JUGANDO:
          musicaJugando.rewind();
          musicaJugando.loop();
          break;
   case ESTADO_NIVEL2:
          musicaNivel2.rewind();
          musicaNivel2.loop();
          break;
        default: // Para gameover y otros estados sin música
          break;
      }
    }
    
    estadoActual = nuevoEstado;
  }
  void setVolumen(float vol) {
    volumen = constrain(vol, 0, 1);
    float dB = map(volumen, 0, 1, -40, 0); // Rango más apropiado
    musicaMenu.setGain(dB);
    musicaJugando.setGain(dB);
    musicaNivel2.setGain(dB);
  }
  
  void toggleMute() {
    muteado = !muteado;
    if (muteado) {
      musicaMenu.mute();
      musicaJugando.mute();
      musicaNivel2.mute();
    } else {
      musicaMenu.unmute();
      musicaJugando.unmute();
      musicaNivel2.unmute();
      actualizar(estadoActual); // Reanudar música si es necesario
    }
  }
  void detener() {
    musicaMenu.close();
    musicaJugando.close();
    musicaNivel2.close();
    minim.stop();
  }
}

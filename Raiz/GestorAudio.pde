class GestorAudio {
  Minim minim; /** */
  AudioPlayer musicaMenu; /** atributo correspondiente a la musica del menu */
  AudioPlayer musicaJugando; /** atributo correspondiente a la musica del nivel 1*/
  AudioPlayer musicaNivel2; /** atributo correspondiente a la musica del nivel 2*/
  AudioPlayer musicavictoria; /** atributo correspondiente a la musica de la victoria*/
  AudioPlayer musicaderrota; /** */
  float volumen = 0.7; /** atributo del volumen*/
  boolean muteado = false; /** atributo del mute*/
  int estadoActual = -1; /** atributo Para controlar cambios*/ 

  /** Carga de archivos de audio*/
  GestorAudio(PApplet app) {
    minim = new Minim(app);
    musicaMenu = minim.loadFile("menu.wav");
    musicaJugando = minim.loadFile("nivel1.mp3");
    musicaNivel2 = minim.loadFile("nivel2.wav");
    musicavictoria = minim.loadFile("victoria.mp3");
    musicaderrota = minim.loadFile("derrota.mp3");
    setVolumen(volumen);
  }

  /** Método auxiliar para detener y reiniciar una pista */ 
  void detener(AudioPlayer m) {
    if (m != null) {
      m.pause();
      m.rewind();
    }
  }
 /** Metodo actualizar con switch del estado de la musica*/
  void actualizar(int nuevoEstado) {
    if (estadoActual == nuevoEstado) return; /** almacenar el estado actual */

    /** Switch para detener musica*/
    switch (estadoActual) {
      case ESTADO_MENU: detener(musicaMenu); break;
      case ESTADO_JUGANDO: detener(musicaJugando); break;
      case ESTADO_NIVEL2: detener(musicaNivel2); break;
      case ESTADO_NIVEL2MENU: detener(musicavictoria); break;
      case ESTADO_GAMEOVER: detener(musicaderrota); break;
      case ESTADO_HORDA: detener(musicaJugando); break;
      case ESTADO_CREDITOS: detener(musicavictoria); break;
    }

    /** Iniciar nueva musica */
    if (!muteado) {
      switch(nuevoEstado) {
        case ESTADO_MENU:
          musicaMenu.rewind(); /** musica rebobinada*/
          musicaMenu.loop(); /** musica en loop*/
          break;
        case ESTADO_JUGANDO:
          musicaJugando.rewind();
          musicaJugando.loop();
          break;
        case ESTADO_NIVEL2:
          musicaNivel2.rewind();
          musicaNivel2.loop();
          break;
        case ESTADO_HORDA:
          musicaJugando.rewind();
          musicaJugando.loop();
          break;
        case ESTADO_CREDITOS:
          musicavictoria.rewind();
          musicavictoria.loop();
          break;
        case ESTADO_NIVEL2MENU:
          musicavictoria.rewind();
          musicavictoria.loop();
          break;
      }
    }

    estadoActual = nuevoEstado; /** almacenar estado*/
  }

  void setVolumen(float vol) { /** metodo para establecer el volumen */
    volumen = constrain(vol, 0, 1);
    float dB = map(volumen, 0, 1, -40, 0);
    musicaMenu.setGain(dB);
    musicaJugando.setGain(dB);
    musicaNivel2.setGain(dB);
    musicavictoria.setGain(dB);
    musicaderrota.setGain(dB);
  }

  void toggleMute(boolean muteado) { /** metodo para activar el mute o desactivarlo */
    this.muteado = muteado;
    if (muteado) {
      musicaMenu.mute();
      musicaJugando.mute();
      musicaNivel2.mute();
      musicaderrota.mute();
      musicavictoria.mute();
    } else {
      musicaMenu.unmute();
      musicaJugando.unmute();
      musicaNivel2.unmute();
      musicaderrota.unmute();
      musicavictoria.unmute();
      actualizar(estadoActual); // reanudar la música del estado actual
    }
  }

  void detener() { /** Metodo para detener la musica*/
    musicaMenu.close();
    musicaJugando.close();
    musicaNivel2.close();
    musicaderrota.close();
    musicavictoria.close();
    minim.stop();
  }

  void detenerMusicaActual() { /** switch para detener la musica que se esta escuchando */
    switch (estadoActual) {
      case ESTADO_MENU: detener(musicaMenu); break;
      case ESTADO_JUGANDO: detener(musicaJugando); break;
      case ESTADO_NIVEL2: detener(musicaNivel2); break;
      case ESTADO_HORDA: detener(musicaJugando); break;
      case ESTADO_CREDITOS: detener(musicavictoria); break;
      case ESTADO_GAMEOVER: detener(musicaderrota); break;
      case ESTADO_NIVEL2MENU: detener(musicavictoria); break;
    }
  }
}

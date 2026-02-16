// pantallas/pagina_juego.dart
// Controla toda la lógica del juego y decide qué pantalla mostrar

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../modelos/estado_juego.dart';
import 'pantalla_menu.dart';
import 'pantalla_jugando.dart';
import 'pantalla_reintentar.dart';
import 'pantalla_resultado.dart';

class PaginaJuego extends StatefulWidget {
  const PaginaJuego({super.key});

  @override
  State<PaginaJuego> createState() => _EstadoPaginaJuego();
}

class _EstadoPaginaJuego extends State<PaginaJuego> {
  // ================= VARIABLES DEL JUEGO =================

  // Estado actual del juego (comienza en menú)
  EstadoJuego estadoActual = EstadoJuego.menu;

  // Variables de nivel y vidas
  int nivelActual = 1; // Nivel actual (1, 2, o 3)
  int vidasRestantes = 3; // Vidas del jugador
  int tiempoRestante = 30; // Tiempo restante en segundos

  // Variables de posición
  double posicionJugadorY = 560; // Posición vertical del jugador
  final double posicionMetaY = 170; // Posición de la línea de meta
  final double tamanoJugador = 70; // Tamaño del jugador

  // Estado de la muñeca
  bool munecaMirando = false; // false = luz verde, true = luz roja

  // Temporizadores
  Timer? temporizadorMovimiento; // Controla el movimiento del jugador
  Timer? temporizadorTiempo; // Controla la cuenta regresiva
  Timer? temporizadorMuneca; // Controla el cambio de la muñeca

  // Generador de números aleatorios
  final Random aleatorio = Random();

  // ================= VELOCIDAD DEL JUGADOR =================
  // Calcula la velocidad según el nivel
  // Nivel 1 = 3.5, Nivel 2 = 4.5, Nivel 3 = 5.5
  double get velocidad => 2.5 + nivelActual;

  // ================= INICIAR EL JUEGO =================

  // Función que inicia el juego desde cero
  void iniciarJuego() {
    setState(() {
      estadoActual = EstadoJuego.jugando; // Cambia a modo jugando
      nivelActual = 1; // Comienza en nivel 1
      vidasRestantes = 3; // Resetea las vidas
    });
    iniciarNivel(); // Inicia el primer nivel
  }

  // Función que inicia un nivel específico
  void iniciarNivel() {
    detenerTodosTemporizadores(); // Detiene todos los temporizadores anteriores

    setState(() {
      posicionJugadorY = 560; // Coloca al jugador al inicio

      tiempoRestante =
          30 -
          nivelActual *
              2; // aca hacemos el calculo del tiempo del nivel 1=28s, Nivel 2=26s, Nivel 3=24s
      munecaMirando = false; // Comienza con luz verde
    });

    // Temporizador que reduce el tiempo cada segundo
    temporizadorTiempo = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => tiempoRestante--); // Reduce 1 segundo
      if (tiempoRestante <= 0) perderVida(); // Si se acaba el tiempo, pierde
    });

    cambiarMuneca(); // Inicia el comportamiento de la muñeca
  }

  // ================= COMPORTAMIENTO DE LA MUÑECA =================

  // Función que hace que la muñeca cambie entre mirar y no mirar
  void cambiarMuneca() {
    // Calcula tiempo aleatorio según el nivel
    // Nivel 1 = 1-3 segundos
    // Nivel 2 = 1-2 segundos
    // Nivel 3 = 1 segundo
    int tiempoEspera = aleatorio.nextInt(4 - nivelActual) + 1;

    temporizadorMuneca = Timer(Duration(seconds: tiempoEspera), () {
      setState(() => munecaMirando = !munecaMirando); // Cambia el estado
      cambiarMuneca(); // Se llama a sí misma recursivamente
    });
  }

  // ================= MOVIMIENTO DEL JUGADOR =================

  // Función que inicia el movimiento cuando se presiona el botón
  void iniciarMovimiento() {
    // Si la muñeca está mirando y el jugador se mueve, pierde
    if (munecaMirando) {
      perderVida();
      return;
    }

    // Cancela el temporizador anterior si existe
    temporizadorMovimiento?.cancel();

    // Temporizador que mueve al jugador cada 30 milisegundos
    temporizadorMovimiento = Timer.periodic(const Duration(milliseconds: 30), (
      _,
    ) {
      // Verifica si llegó a la meta
      if (posicionJugadorY + tamanoJugador <= posicionMetaY) {
        siguienteNivel(); // Avanza al siguiente nivel
        return;
      }

      // Verifica si la muñeca se volteó mientras se movía
      if (munecaMirando) {
        perderVida();
        return;
      }

      // Mueve al jugador hacia arriba
      setState(() => posicionJugadorY -= velocidad);
    });
  }

  // Función que detiene el movimiento cuando se suelta el botón
  void detenerMovimiento() {
    temporizadorMovimiento?.cancel();
  }

  // ================= PERDER UNA VIDA =================

  // Función que se ejecuta cuando el jugador pierde una vida
  void perderVida() {
    detenerTodosTemporizadores(); // Detiene todos los temporizadores
    HapticFeedback.heavyImpact(); // Vibración del dispositivo
    vidasRestantes--; // Reduce las vidas

    // Verifica si aún tiene vidas
    if (vidasRestantes <= 0) {
      // Si no tiene vidas, pierde el juego
      setState(() => estadoActual = EstadoJuego.derrota);
    } else {
      // Si tiene vidas, espera 700ms y muestra pantalla de reintentar
      Future.delayed(const Duration(milliseconds: 700), () {
        setState(() => estadoActual = EstadoJuego.reintentar);
      });
    }
  }

  // Función que reinicia el nivel actual
  void reintentarNivel() {
    setState(() => estadoActual = EstadoJuego.jugando);
    iniciarNivel();
  }

  // ================= SIGUIENTE NIVEL =================

  // Función que se ejecuta al completar un nivel
  void siguienteNivel() {
    detenerTodosTemporizadores();
    HapticFeedback.mediumImpact(); // Vibración de retroalimentación

    // Verifica si completó el nivel 3
    if (nivelActual == 3) {
      setState(() => estadoActual = EstadoJuego.victoria); // Gana el juego
    } else {
      nivelActual++; // Aumenta el nivel
      iniciarNivel(); // Inicia el siguiente nivel
    }
  }

  // ================= DETENER TEMPORIZADORES =================

  // Función que detiene todos los temporizadores
  void detenerTodosTemporizadores() {
    temporizadorMovimiento?.cancel();
    temporizadorTiempo?.cancel();
    temporizadorMuneca?.cancel();
  }

  // ================= VOLVER AL MENÚ =================

  // Función que regresa al menú principal
  void volverAlMenu() {
    setState(() => estadoActual = EstadoJuego.menu);
  }

  // ================= LIMPIAR AL DESTRUIR =================
  // Función del ciclo de vida que se ejecuta al destruir el widget
  @override
  void dispose() {
    detenerTodosTemporizadores(); // Detiene todos los temporizadores
    super.dispose();
  }

  // ================= CONSTRUCCIÓN DE LA INTERFAZ =================

  @override
  Widget build(BuildContext context) {
    // Decide qué pantalla mostrar según el estado
    switch (estadoActual) {
      case EstadoJuego.menu:
        // Pantalla de menú
        return PantallaMenu(alIniciarJuego: iniciarJuego);

      case EstadoJuego.jugando:
        //Pantalla de juego
        return PantallaJugando(
          nivel: nivelActual,
          vidas: vidasRestantes,
          tiempoRestante: tiempoRestante,
          munecaMirando: munecaMirando,
          posicionJugadorY: posicionJugadorY,
          posicionMetaY: posicionMetaY,
          tamanoJugador: tamanoJugador,
          alIniciarMovimiento: iniciarMovimiento,
          alDetenerMovimiento: detenerMovimiento,
        );

      case EstadoJuego.reintentar:
        // Pantalla de reintentar
        return PantallaReintentar(
          vidas: vidasRestantes,
          alReintentar: reintentarNivel,
        );

      case EstadoJuego.victoria:
        // Pantalla de victoria
        return PantallaResultado(
          titulo: "¡VICTORIA!",
          subtitulo: "Has completado todos los niveles",
          colorFondo: Colors.green,
          icono: Icons.emoji_events,
          alVolverMenu: volverAlMenu,
        );

      case EstadoJuego.derrota:
        // Pantalla de derrota
        return PantallaResultado(
          titulo: "ELIMINADO",
          subtitulo: "No lograste cruzar la línea",
          colorFondo: Colors.red,
          icono: Icons.dangerous,
          alVolverMenu: volverAlMenu,
        );
    }
  }
}

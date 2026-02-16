// pantallas/pantalla_jugando.dart
// Pantalla principal donde se juega

import 'package:flutter/material.dart';
import '../widgets/caja_informacion.dart';

class PantallaJugando extends StatelessWidget {
  // Variables del estado del juego
  final int nivel; // Nivel actual
  final int vidas; // Vidas restantes
  final int tiempoRestante; // Tiempo restante
  final bool munecaMirando; // La muñeca está mirando
  final double posicionJugadorY; // Posición vertical del jugador
  final double posicionMetaY; // Posición de la línea de meta
  final double tamanoJugador; // Tamaño del jugador

  // Funciones de control
  final VoidCallback alIniciarMovimiento; // Cuando presiona para moverse
  final VoidCallback alDetenerMovimiento; // Cuando suelta para detenerse

  const PantallaJugando({
    super.key,
    required this.nivel,
    required this.vidas,
    required this.tiempoRestante,
    required this.munecaMirando,
    required this.posicionJugadorY,
    required this.posicionMetaY,
    required this.tamanoJugador,
    required this.alIniciarMovimiento,
    required this.alDetenerMovimiento,
  });

  @override
  Widget build(BuildContext context) {
    // Obtener el ancho de la pantalla
    final anchoPantalla = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.cover,
            ),
          ),

          // Contenido del juego
          Column(
            children: [
              const SizedBox(height: 40),

              // Fila con información del juego
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CajaInformacion(titulo: "Nivel", valor: "$nivel"),
                  CajaInformacion(titulo: "Vidas", valor: "$vidas"),
                  CajaInformacion(titulo: "Tiempo", valor: "$tiempoRestante"),
                ],
              ),
              const SizedBox(height: 10),

              // Indicador de luz roja o verde
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  // Color según el estado de la muñeca
                  color: munecaMirando ? Colors.red : Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  munecaMirando ? "🔴 LUZ ROJA" : "🟢 LUZ VERDE",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Área de juego
              Expanded(
                child: Stack(
                  children: [
                    // Muñeca
                    Positioned(
                      top: 20,
                      left: anchoPantalla / 2 - 75, // Centrada
                      child: Image.asset(
                        // Imagen según si está mirando o no
                        munecaMirando
                            ? "assets/images/doll_front.png"
                            : "assets/images/doll_back.png",
                        width: 150,
                        height: 150,
                      ),
                    ),

                    // Línea de meta
                    Positioned(
                      top: posicionMetaY,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 8,
                        color: Colors.yellow, // Línea amarilla simple
                      ),
                    ),

                    // Jugador
                    Positioned(
                      top: posicionJugadorY, // Posición que cambia al moverse
                      left: anchoPantalla / 2 - tamanoJugador / 2, // Centrado
                      child: Image.asset(
                        "assets/images/player.png",
                        width: tamanoJugador,
                        height: tamanoJugador,
                      ),
                    ),
                  ],
                ),
              ),

              // Botón de control
              GestureDetector(
                // Cuando presiona, inicia el movimiento
                onTapDown: (_) => alIniciarMovimiento(),
                // Cuando suelta, detiene el movimiento
                onTapUp: (_) => alDetenerMovimiento(),
                // Si cancela el toque, detiene el movimiento
                onTapCancel: alDetenerMovimiento,
                child: Container(
                  height: 90,
                  color: Colors.green, // Fondo verde simple
                  child: const Center(
                    child: Text(
                      "MANTÉN PRESIONADO PARA MOVER",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

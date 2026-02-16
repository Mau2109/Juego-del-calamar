// pantallas/pantalla_menu.dart
// Pantalla de inicio del juego

import 'package:flutter/material.dart';

class PantallaMenu extends StatelessWidget {
  // Función que se ejecuta al presionar el botón de jugar
  final VoidCallback alIniciarJuego;

  const PantallaMenu({
    super.key,
    required this.alIniciarJuego,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo negro simple
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título "EL JUEGO DEL"
            const Text(
              "EL JUEGO DEL",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w300,
                color: Colors.red,
                letterSpacing: 8,
              ),
            ),
            const SizedBox(height: 10),
            
            // Título "CALAMAR"
            const Text(
              "CALAMAR",
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                color: Colors.red,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 60),
            
            // Botón de JUGAR
            ElevatedButton(
              onPressed: alIniciarJuego, // Ejecuta la función al presionar
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Fondo rojo
                foregroundColor: Colors.white, // Texto blanco
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
              ),
              child: const Text(
                "JUGAR",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Subtítulo
            const Text(
              "LUZ ROJA, LUZ VERDE",
              style: TextStyle(
                color: Colors.white60,
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

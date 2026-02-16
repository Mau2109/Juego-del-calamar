// pantallas/pantalla_resultado.dart
// Pantalla que se muestra al ganar o perder el juego

import 'package:flutter/material.dart';

class PantallaResultado extends StatelessWidget {
  // Título principal (ej: "¡VICTORIA!" o "ELIMINADO")
  final String titulo;
  // Subtítulo descriptivo
  final String subtitulo;
  // Color de fondo de la pantalla
  final Color colorFondo;
  // Icono a mostrar
  final IconData icono;
  // Función que se ejecuta al presionar "Volver al menú"
  final VoidCallback alVolverMenu;

  const PantallaResultado({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.colorFondo,
    required this.icono,
    required this.alVolverMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Color de fondo según el resultado (verde para victoria, rojo para derrota)
      backgroundColor: colorFondo,
      // Sin AppBar - pantalla completa
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono grande
              Icon(icono, size: 120, color: Colors.white),
              const SizedBox(height: 30),

              // Título principal
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 15),

              // Subtítulo
              Text(
                subtitulo,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.white70),
              ),
              const SizedBox(height: 50),

              // Botón para volver al menú
              ElevatedButton(
                onPressed: alVolverMenu, // Ejecuta la función al presionar
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Fondo blanco
                  foregroundColor: colorFondo, // Texto del color de fondo
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "VOLVER AL MENÚ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// principal.dart
// Archivo principal que inicia la aplicación Flutter

import 'package:flutter/material.dart';
import 'pantallas/pagina_juego.dart';

// Función main - punto de entrada de la aplicación
void main() {
  runApp(const AplicacionJuegoCalamar());
}

// Widget raíz de la aplicación
class AplicacionJuegoCalamar extends StatelessWidget {
  const AplicacionJuegoCalamar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Oculta el banner de DEBUG
      debugShowCheckedModeBanner: false,
      // Pantalla inicial
      home: PaginaJuego(),
    );
  }
}

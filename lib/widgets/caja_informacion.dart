// Widget reutilizable para mostrar información del juego (nivel, vidas, tiempo)

import 'package:flutter/material.dart';

class CajaInformacion extends StatelessWidget {
  // Variables que recibe el widget
  final String titulo;
  final String valor;

  const CajaInformacion({super.key, required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Espaciado interno
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // Decoración de la caja
      decoration: BoxDecoration(
        color: Colors.black87, // Color de fondo negro
        borderRadius: BorderRadius.circular(10), // Bordes redondeados
        border: Border.all(color: Colors.white, width: 2), // Borde blanco
      ),
      child: Column(
        children: [
          // Título
          Text(
            titulo,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          // Valor
          Text(
            valor,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

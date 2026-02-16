// pantallas/pantalla_reintentar.dart
// Pantalla que se muestra cuando el jugador pierde una vida

import 'package:flutter/material.dart';

class PantallaReintentar extends StatelessWidget {
  // Vidas restantes del jugador
  final int vidas;
  // Función que se ejecuta al presionar "Reintentar"
  final VoidCallback alReintentar;

  const PantallaReintentar({
    super.key,
    required this.vidas,
    required this.alReintentar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo naranja simple
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono de advertencia
            const Icon(
              Icons.warning_amber_rounded,
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 30),
            
            // Mensaje de error
            const Text(
              "¡TE MOVISTE!",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            
            // Mostrar vidas restantes
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icono de corazón
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  // Texto con vidas restantes
                  Text(
                    "Vidas restantes: $vidas",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            // Botón de REINTENTAR
            ElevatedButton(
              onPressed: alReintentar, // Ejecuta la función al presionar
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Fondo blanco
                foregroundColor: Colors.orange, // Texto naranja
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "INTENTAR DE NUEVO",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

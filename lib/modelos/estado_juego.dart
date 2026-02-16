// modelos/estado_juego.dart
// Define los posibles estados del juego

// Enumeración con todos los estados posibles
enum EstadoJuego {
  menu,       // Pantalla de inicio
  jugando,    // Jugando
  reintentar, // Pantalla de reintentar (perdió una vida)
  victoria,   // Pantalla de victoria
  derrota,    // Pantalla de derrota (Game Over)
}

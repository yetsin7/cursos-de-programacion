// =============================================================================
// ARCHIVO: 02_parametros.dart
// TEMA: Tipos de parámetros en Dart — posicionales, nombrados y opcionales
// =============================================================================
//
// Dart ofrece tres formas de pasar parámetros a las funciones. Entender
// la diferencia es fundamental porque en Flutter TODOS los widgets usan
// parámetros nombrados. Esto hace el código de Flutter legible y explícito.
//
// CÓMO EJECUTAR:
//   dart run 02_parametros.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // PARÁMETROS POSICIONALES — El estilo tradicional
  // ─────────────────────────────────────────────────────────────────────────

  // Se pasan en el orden en que están definidos. Son obligatorios.
  // Útil cuando hay pocos parámetros y el orden es obvio.
  print('--- Parámetros posicionales ---');
  print(dividir(10, 2));      // 5.0 — el orden importa
  print(dividir(2, 10));      // 0.2 — invertir el orden cambia el resultado

  // ─────────────────────────────────────────────────────────────────────────
  // PARÁMETROS NOMBRADOS — Con llaves {}
  // ─────────────────────────────────────────────────────────────────────────

  // Los parámetros entre llaves {} son NOMBRADOS.
  // Se pueden pasar en cualquier orden usando el nombre como clave.
  // Son opcionales por defecto (a menos que uses "required").
  // Son LA forma estándar en Flutter — todos los widgets los usan así.
  print('\n--- Parámetros nombrados ---');

  // Con parámetros nombrados el orden no importa:
  crearUsuario(nombre: 'Ana', edad: 28, ciudad: 'Managua');
  crearUsuario(edad: 34, nombre: 'Luis', ciudad: 'León');

  // Si son opcionales (sin required), se pueden omitir:
  mostrarInfo(titulo: 'Flutter');          // solo título, sin subtítulo
  mostrarInfo(titulo: 'Dart', subtitulo: 'El lenguaje');

  // ─────────────────────────────────────────────────────────────────────────
  // REQUIRED — Parámetros nombrados obligatorios
  // ─────────────────────────────────────────────────────────────────────────

  // "required" hace que un parámetro nombrado sea obligatorio.
  // El compilador dará error si no lo pasas.
  // Úsalo cuando el parámetro es esencial para que la función funcione.
  print('\n--- required ---');

  // Nota: la función crearTarjeta tiene todos los parámetros required.
  // No puedes omitir ninguno sin que el compilador proteste.
  crearTarjeta(titulo: 'Hola Mundo', contenido: 'Este es el contenido');

  // ─────────────────────────────────────────────────────────────────────────
  // VALORES POR DEFECTO — Para parámetros opcionales
  // ─────────────────────────────────────────────────────────────────────────

  // Los parámetros nombrados opcionales pueden tener valores por defecto.
  // Si no se pasan, usan el valor por defecto. Si se pasan, usan el pasado.
  print('\n--- Valores por defecto ---');

  conectar();                           // Usa puerto:8080, ssl:false (defecto)
  conectar(puerto: 443, ssl: true);     // Usa los valores pasados
  conectar(puerto: 3000);              // ssl sigue siendo false (defecto)

  // ─────────────────────────────────────────────────────────────────────────
  // PARÁMETROS POSICIONALES OPCIONALES — Con corchetes []
  // ─────────────────────────────────────────────────────────────────────────

  // Los parámetros entre corchetes [] son posicionales PERO opcionales.
  // Se acceden por posición, no por nombre. Son menos comunes que {} en Dart.
  print('\n--- Parámetros posicionales opcionales ---');

  print(formatearNombre('Juan'));              // Solo nombre
  print(formatearNombre('Juan', 'Pérez'));     // Nombre y apellido
  print(formatearNombre('Ana', 'García', 'Dra.')); // Con título

  // ─────────────────────────────────────────────────────────────────────────
  // MEZCLA: POSICIONALES + NOMBRADOS
  // ─────────────────────────────────────────────────────────────────────────

  // Una función puede tener parámetros posicionales Y nombrados.
  // Los posicionales van primero, los nombrados después.
  print('\n--- Mezcla posicionales + nombrados ---');

  enviarEmail('hola@example.com', asunto: 'Bienvenido', cuerpo: 'Hola!');
  enviarEmail('otro@example.com', asunto: 'Aviso');  // cuerpo es opcional
}

/// Divide dos números. Parámetros posicionales tradicionales.
double dividir(double a, double b) {
  if (b == 0) return double.infinity;
  return a / b;
}

/// Crea un usuario con parámetros nombrados (todos required).
void crearUsuario({
  required String nombre,
  required int edad,
  required String ciudad,
}) {
  print('Usuario: $nombre, $edad años, $ciudad');
}

/// Muestra información con parámetros nombrados opcionales.
/// [subtitulo] es opcional — si no se pasa, se usa null.
void mostrarInfo({required String titulo, String? subtitulo}) {
  if (subtitulo != null) {
    print('$titulo — $subtitulo');
  } else {
    print(titulo);
  }
}

/// Crea una tarjeta con parámetros required.
void crearTarjeta({required String titulo, required String contenido}) {
  print('┌─────────────────┐');
  print('│ $titulo');
  print('│ $contenido');
  print('└─────────────────┘');
}

/// Simula conectar a un servidor con valores por defecto para puerto y ssl.
void conectar({String host = 'localhost', int puerto = 8080, bool ssl = false}) {
  String protocolo = ssl ? 'https' : 'http';
  print('Conectando a $protocolo://$host:$puerto');
}

/// Formatea un nombre completo con título opcional.
/// Usa parámetros posicionales opcionales [].
String formatearNombre(String nombre, [String? apellido, String? titulo]) {
  String resultado = nombre;
  if (apellido != null) resultado = '$resultado $apellido';
  if (titulo != null) resultado = '$titulo $resultado';
  return resultado;
}

/// Envía un email. Combina posicional (destinatario) y nombrados.
void enviarEmail(String destinatario, {required String asunto, String cuerpo = ''}) {
  print('Para: $destinatario | Asunto: $asunto | Cuerpo: "${cuerpo.isEmpty ? "(vacío)" : cuerpo}"');
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega un parámetro "bool activo = true" a crearUsuario y úsalo.
//   2. Crea una función "calcularImc(double peso, double altura)" y luego
//      una versión con parámetros nombrados. ¿Cuál es más legible al llamarla?
//   3. ¿Qué pasa si intentas pasar un parámetro nombrado extra que no existe?
//      Prueba: conectar(puerto: 80, timeout: 30) — ¿qué error da?
//   4. Crea una función con 5 parámetros nombrados opcionales. Llámala
//      pasando solo 2 de ellos. Verifica cuáles tienen valor por defecto.
//   5. En Flutter, los constructores de widgets usan parámetros nombrados.
//      Observa Text('Hola', style: TextStyle(fontSize: 16)) — ¿ves el patrón?
// =============================================================================

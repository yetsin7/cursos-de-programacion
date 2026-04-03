// =============================================================================
// ARCHIVO: 05_ejercicios.dart
// TEMA: Ejercicios prácticos — Módulo 05: Colecciones
// =============================================================================
//
// Ejercicios que combinan List, Map, Set e Iterable con casos de uso reales.
// Intenta resolverlos antes de ver las soluciones comentadas.
//
// CÓMO EJECUTAR:
//   dart run 05_ejercicios.dart
//
// =============================================================================

void main() {
  print('====== EJERCICIOS — MÓDULO 05: COLECCIONES ======\n');

  ejercicio1();
  ejercicio2();
  ejercicio3();
  ejercicio4();
  ejercicio5();
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1 — Estadísticas de una lista
// ─────────────────────────────────────────────────────────────────────────────

/// Dada una lista de calificaciones [87, 92, 78, 95, 88, 76, 90, 83, 91, 85],
/// calcula y muestra:
/// - Promedio
/// - Calificación más alta y más baja
/// - Cuántos están por encima del promedio
/// - Porcentaje de aprobados (>= 80)
void ejercicio1() {
  print('--- EJERCICIO 1: Estadísticas ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  var calificaciones = [87, 92, 78, 95, 88, 76, 90, 83, 91, 85];

  double promedio = calificaciones.reduce((a, b) => a + b) / calificaciones.length;
  int maxNota = calificaciones.reduce((a, b) => a > b ? a : b);
  int minNota = calificaciones.reduce((a, b) => a < b ? a : b);
  int sobrePromedio = calificaciones.where((n) => n > promedio).length;
  double pctAprobados = calificaciones.where((n) => n >= 80).length / calificaciones.length * 100;

  print('Calificaciones: $calificaciones');
  print('Promedio: ${promedio.toStringAsFixed(2)}');
  print('Máxima: $maxNota | Mínima: $minNota');
  print('Sobre el promedio: $sobrePromedio de ${calificaciones.length}');
  print('Aprobados (≥80): ${pctAprobados.toStringAsFixed(1)}%');
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2 — Frecuencia de palabras
// ─────────────────────────────────────────────────────────────────────────────

/// Dado un texto, construye un Map<String, int> con la frecuencia
/// de cada palabra (ignorando mayúsculas/minúsculas).
/// Luego imprime las 5 palabras más frecuentes.
void ejercicio2() {
  print('--- EJERCICIO 2: Frecuencia de palabras ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  const texto = '''
    Dart es un lenguaje moderno y dart es fácil de aprender.
    Flutter usa dart como su lenguaje principal.
    Dart tiene null safety y dart es rápido.
  ''';

  // Normalizar: minúsculas, limpiar puntuación, dividir en palabras
  var palabras = texto
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w\s]'), '')  // Quitar puntuación
      .split(RegExp(r'\s+'))               // Dividir por espacios
      .where((p) => p.isNotEmpty)          // Quitar cadenas vacías
      .toList();

  // Construir mapa de frecuencias
  Map<String, int> frecuencias = {};
  for (var palabra in palabras) {
    frecuencias[palabra] = (frecuencias[palabra] ?? 0) + 1;
  }

  // Ordenar por frecuencia descendente y tomar top 5
  var top5 = frecuencias.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  print('Top 5 palabras más frecuentes:');
  for (int i = 0; i < 5 && i < top5.length; i++) {
    print('  ${(i + 1)}. "${top5[i].key}": ${top5[i].value} veces');
  }
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3 — Operaciones de conjuntos con usuarios
// ─────────────────────────────────────────────────────────────────────────────

/// Tienes dos grupos de usuarios:
/// - Grupo A (suscriptores premium): ana, luis, carlos, pedro, sofia
/// - Grupo B (usuarios activos este mes): luis, sofia, maria, jose, carlos
/// Encuentra:
/// 1. Usuarios en ambos grupos (activos Y premium)
/// 2. Solo en grupo A (premium pero no activos)
/// 3. Solo en grupo B (activos pero no premium)
/// 4. En alguno de los dos grupos (todos los relevantes)
void ejercicio3() {
  print('--- EJERCICIO 3: Operaciones de conjuntos ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  Set<String> premium = {'ana', 'luis', 'carlos', 'pedro', 'sofia'};
  Set<String> activos = {'luis', 'sofia', 'maria', 'jose', 'carlos'};

  print('Premium: $premium');
  print('Activos: $activos');
  print('');
  print('Activos Y premium: ${premium.intersection(activos)}');
  print('Premium pero NO activos: ${premium.difference(activos)}');
  print('Activos pero NO premium: ${activos.difference(premium)}');
  print('Todos los relevantes: ${premium.union(activos)}');
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 4 — Agrupar por criterio
// ─────────────────────────────────────────────────────────────────────────────

/// Dada una lista de productos con nombre y precio, agrúpalos por categoría:
/// - "barato" (precio < 20)
/// - "medio" (20 <= precio < 100)
/// - "caro" (precio >= 100)
/// El resultado debe ser Map<String, List<String>> con los nombres por categoría.
void ejercicio4() {
  print('--- EJERCICIO 4: Agrupar productos ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  var productos = [
    {'nombre': 'Lápiz', 'precio': 2.5},
    {'nombre': 'Libro', 'precio': 35.0},
    {'nombre': 'Laptop', 'precio': 850.0},
    {'nombre': 'Borrador', 'precio': 1.0},
    {'nombre': 'Mochila', 'precio': 75.0},
    {'nombre': 'Teléfono', 'precio': 450.0},
    {'nombre': 'Cuaderno', 'precio': 8.5},
    {'nombre': 'Monitor', 'precio': 250.0},
  ];

  Map<String, List<String>> grupos = {
    'barato': [],
    'medio': [],
    'caro': [],
  };

  for (var producto in productos) {
    double precio = (producto['precio'] as num).toDouble();
    String nombre = producto['nombre'] as String;

    String categoria = switch (precio) {
      < 20 => 'barato',
      < 100 => 'medio',
      _ => 'caro',
    };
    grupos[categoria]!.add(nombre);
  }

  grupos.forEach((categoria, nombres) {
    print('$categoria: $nombres');
  });
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 5 — Pipeline con Iterable y generator
// ─────────────────────────────────────────────────────────────────────────────

/// Usa un generator para producir los primeros 50 números enteros.
/// Luego aplica este pipeline:
/// 1. Filtrar los que son divisibles por 3 o por 5
/// 2. Calcular el cuadrado de cada uno
/// 3. Tomar solo los primeros 10 resultados
/// 4. Mostrar la suma total de esos 10 valores
void ejercicio5() {
  print('--- EJERCICIO 5: Pipeline con generator ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  Iterable<int> generarEnteros(int hasta) sync* {
    for (int i = 1; i <= hasta; i++) {
      yield i;
    }
  }

  var pipeline = generarEnteros(50)
      .where((n) => n % 3 == 0 || n % 5 == 0)  // Divisibles por 3 o 5
      .map((n) => n * n)                          // Al cuadrado
      .take(10);                                  // Solo los primeros 10

  var resultados = pipeline.toList();
  int suma = resultados.reduce((a, b) => a + b);

  print('Primeros 10 cuadrados de divisibles por 3 o 5:');
  for (int i = 0; i < resultados.length; i++) {
    print('  ${(i + 1).toString().padLeft(2)}. ${resultados[i]}');
  }
  print('Suma total: $suma');
}

// =============================================================================
// EXPERIMENTA:
//   1. En ejercicio 2, ignora las "stop words" (el, la, de, y, a, en, es)
//      antes de contar frecuencias.
//   2. En ejercicio 4, ordena cada grupo de productos alfabéticamente.
//   3. Crea un "índice invertido": dado un Map<libro, palabras>, construye
//      un Map<palabra, libros> que diga en qué libros aparece cada palabra.
//   4. Dado un mapa de ventas por día, calcula el promedio semanal y los
//      días que estuvieron por encima del promedio.
//   5. Usa Iterable.generate() para crear coordenadas (x, y) en forma de
//      Records: Iterable.generate(5, (i) => (x: i, y: i*i))
// =============================================================================

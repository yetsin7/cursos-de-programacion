// =============================================================================
// ARCHIVO: gestor_contactos.dart
// TEMA: Proyecto integrador — Gestor de Contactos en consola
// =============================================================================
//
// Aplicación de consola completa que integra: clases, null safety,
// colecciones, strings, manejo de errores y entrada del usuario.
// Demuestra cómo los conceptos aprendidos se combinan en una app real.
//
// CÓMO EJECUTAR:
//   dart run gestor_contactos.dart
//
// =============================================================================

import 'dart:io';

// ────────────────────────────────────────────────────────────────────────────
// MODELO: Contacto
// ────────────────────────────────────────────────────────────────────────────

/// Representa un contacto con sus datos personales.
///
/// Email es opcional (puede no estar registrado).
/// Favorito indica si el contacto está marcado como especial.
class Contacto {
  // Nombre del contacto
  final String nombre;
  // Número de teléfono principal
  final String telefono;
  // Dirección de email (opcional)
  final String? email;
  // Indica si el contacto está marcado como favorito
  bool favorito;

  /// Crea un contacto con nombre y teléfono obligatorios.
  /// Email es opcional. Favorito es false por defecto.
  Contacto({
    required this.nombre,
    required this.telefono,
    this.email,
    this.favorito = false,
  });

  /// Constructor de ejemplo para precargar datos al inicio.
  Contacto.ejemplo(this.nombre, this.telefono, {this.email, this.favorito = false});

  /// Verifica si este contacto tiene email registrado.
  bool get tieneEmail => email != null && email!.isNotEmpty;

  /// Verifica si el nombre o teléfono contienen el [termino] de búsqueda.
  bool coincidenConBusqueda(String termino) {
    String t = termino.toLowerCase().trim();
    return nombre.toLowerCase().contains(t) || telefono.contains(t);
  }

  /// Devuelve una representación formateada del contacto para la consola.
  String mostrar({int indice = 0}) {
    String fav = favorito ? ' ★' : '';
    String emailStr = tieneEmail ? '\n     Email: $email' : '';
    String idx = indice > 0 ? '[$indice] ' : '     ';
    return '$idx${nombre}$fav\n     Tel: $telefono$emailStr';
  }

  @override
  String toString() => '$nombre ($telefono)';
}

// ────────────────────────────────────────────────────────────────────────────
// GESTOR: Lógica de la aplicación
// ────────────────────────────────────────────────────────────────────────────

/// Gestor principal de contactos — contiene toda la lógica de negocio.
///
/// Administra la lista de contactos y provee operaciones CRUD básicas.
class GestorContactos {
  // Lista interna de contactos
  final List<Contacto> _contactos = [];

  /// Devuelve todos los contactos (copia inmutable).
  List<Contacto> get todos => List.unmodifiable(_contactos);

  /// Devuelve solo los contactos marcados como favoritos.
  List<Contacto> get favoritos =>
      _contactos.where((c) => c.favorito).toList();

  /// Número total de contactos almacenados.
  int get total => _contactos.length;

  /// Agrega un [contacto] a la lista.
  void agregar(Contacto contacto) => _contactos.add(contacto);

  /// Busca contactos que coincidan con el [termino].
  /// Devuelve lista vacía si no hay coincidencias.
  List<Contacto> buscar(String termino) =>
      _contactos.where((c) => c.coincidenConBusqueda(termino)).toList();

  /// Alterna el estado de favorito del contacto en [indice] (base 0).
  /// Devuelve el nuevo estado, o null si el índice es inválido.
  bool? alternarFavorito(int indice) {
    if (indice < 0 || indice >= _contactos.length) return null;
    _contactos[indice].favorito = !_contactos[indice].favorito;
    return _contactos[indice].favorito;
  }

  /// Elimina el contacto en [indice] (base 0).
  /// Devuelve el contacto eliminado, o null si el índice es inválido.
  Contacto? eliminar(int indice) {
    if (indice < 0 || indice >= _contactos.length) return null;
    return _contactos.removeAt(indice);
  }
}

// ────────────────────────────────────────────────────────────────────────────
// UI: Funciones de presentación en consola
// ────────────────────────────────────────────────────────────────────────────

/// Imprime el encabezado de la aplicación.
void mostrarEncabezado() {
  print('\n${'═' * 45}');
  print('         GESTOR DE CONTACTOS');
  print('═' * 45);
}

/// Imprime el menú principal de opciones.
void mostrarMenu() {
  print('\n  1. Ver todos los contactos');
  print('  2. Agregar contacto');
  print('  3. Buscar contacto');
  print('  4. Marcar/desmarcar favorito');
  print('  5. Eliminar contacto');
  print('  6. Ver favoritos');
  print('  7. Salir');
  print('\n${'─' * 45}');
  stdout.write('  Elige una opción (1-7): ');
}

/// Lee una línea de la consola de forma segura.
/// Devuelve string vacío si la entrada es null.
String leerLinea({String prompt = ''}) {
  if (prompt.isNotEmpty) stdout.write(prompt);
  return stdin.readLineSync()?.trim() ?? '';
}

/// Muestra una lista de contactos numerada.
/// Si la lista está vacía, muestra el [mensajeVacio].
void mostrarLista(List<Contacto> lista, {String mensajeVacio = 'No hay contactos.'}) {
  if (lista.isEmpty) {
    print('  $mensajeVacio');
    return;
  }
  for (int i = 0; i < lista.length; i++) {
    print(lista[i].mostrar(indice: i + 1));
    if (i < lista.length - 1) print('  ${'-' * 30}');
  }
}

// ────────────────────────────────────────────────────────────────────────────
// ACCIONES DEL MENÚ
// ────────────────────────────────────────────────────────────────────────────

/// Muestra todos los contactos o un mensaje si no hay ninguno.
void verTodos(GestorContactos gestor) {
  print('\n  ── Todos los contactos (${gestor.total}) ──');
  mostrarLista(gestor.todos, mensajeVacio: 'No hay contactos registrados.');
}

/// Solicita los datos y agrega un nuevo contacto.
void agregarContacto(GestorContactos gestor) {
  print('\n  ── Agregar contacto ──');

  String nombre = leerLinea(prompt: '  Nombre: ');
  if (nombre.isEmpty) {
    print('  El nombre no puede estar vacío. Cancelado.');
    return;
  }

  String telefono = leerLinea(prompt: '  Teléfono: ');
  if (telefono.isEmpty) {
    print('  El teléfono no puede estar vacío. Cancelado.');
    return;
  }

  String emailInput = leerLinea(prompt: '  Email (opcional, Enter para omitir): ');
  String? email = emailInput.isEmpty ? null : emailInput;

  Contacto nuevo = Contacto(nombre: nombre, telefono: telefono, email: email);
  gestor.agregar(nuevo);
  print('  ✓ Contacto "$nombre" agregado exitosamente.');
}

/// Solicita un término y muestra los resultados de búsqueda.
void buscarContacto(GestorContactos gestor) {
  print('\n  ── Buscar contacto ──');
  String termino = leerLinea(prompt: '  Buscar por nombre o teléfono: ');
  if (termino.isEmpty) {
    print('  Escribe un término para buscar.');
    return;
  }

  List<Contacto> resultados = gestor.buscar(termino);
  print('  Resultados para "$termino": ${resultados.length}');
  mostrarLista(resultados, mensajeVacio: 'No se encontraron coincidencias.');
}

/// Permite marcar o desmarcar un contacto como favorito.
void alternarFavorito(GestorContactos gestor) {
  print('\n  ── Marcar/desmarcar favorito ──');
  mostrarLista(gestor.todos, mensajeVacio: 'No hay contactos.');
  if (gestor.total == 0) return;

  String entrada = leerLinea(prompt: '  Número del contacto (1-${gestor.total}): ');
  int? numero = int.tryParse(entrada);

  if (numero == null || numero < 1 || numero > gestor.total) {
    print('  Número inválido. Cancelado.');
    return;
  }

  bool? nuevoEstado = gestor.alternarFavorito(numero - 1);
  if (nuevoEstado == null) {
    print('  Error al actualizar el contacto.');
    return;
  }

  String accion = nuevoEstado ? 'marcado como favorito ★' : 'removido de favoritos';
  print('  ✓ Contacto $accion.');
}

/// Permite eliminar un contacto de la lista.
void eliminarContacto(GestorContactos gestor) {
  print('\n  ── Eliminar contacto ──');
  mostrarLista(gestor.todos, mensajeVacio: 'No hay contactos.');
  if (gestor.total == 0) return;

  String entrada = leerLinea(prompt: '  Número a eliminar (1-${gestor.total}): ');
  int? numero = int.tryParse(entrada);

  if (numero == null || numero < 1 || numero > gestor.total) {
    print('  Número inválido. Cancelado.');
    return;
  }

  String confirmar = leerLinea(
    prompt: '  ¿Confirmar eliminación? (s/N): ',
  ).toLowerCase();

  if (confirmar != 's') {
    print('  Eliminación cancelada.');
    return;
  }

  Contacto? eliminado = gestor.eliminar(numero - 1);
  if (eliminado != null) {
    print('  ✓ Contacto "${eliminado.nombre}" eliminado.');
  }
}

/// Muestra solo los contactos marcados como favoritos.
void verFavoritos(GestorContactos gestor) {
  print('\n  ── Favoritos ★ ──');
  mostrarLista(
    gestor.favoritos,
    mensajeVacio: 'No tienes contactos favoritos. Márcalos con la opción 4.',
  );
}

// ────────────────────────────────────────────────────────────────────────────
// PUNTO DE ENTRADA: main()
// ────────────────────────────────────────────────────────────────────────────

/// Punto de entrada de la aplicación.
///
/// Inicializa el gestor, precarga los datos de ejemplo y ejecuta
/// el bucle principal del menú interactivo.
void main() {
  GestorContactos gestor = GestorContactos();

  // Precargar contactos de ejemplo
  gestor.agregar(Contacto.ejemplo('Pedro Páramo', '555-0001',
      email: 'pedro@ejemplo.com'));
  gestor.agregar(Contacto.ejemplo('Pablo Neruda', '555-0002'));
  gestor.agregar(Contacto.ejemplo('María Martínez', '555-0003',
      email: 'maria@ejemplo.com', favorito: true));

  mostrarEncabezado();
  print('  ${gestor.total} contactos de ejemplo cargados.');

  // Bucle principal del menú
  while (true) {
    mostrarMenu();

    try {
      String opcion = stdin.readLineSync()?.trim() ?? '';

      switch (opcion) {
        case '1':
          verTodos(gestor);
        case '2':
          agregarContacto(gestor);
        case '3':
          buscarContacto(gestor);
        case '4':
          alternarFavorito(gestor);
        case '5':
          eliminarContacto(gestor);
        case '6':
          verFavoritos(gestor);
        case '7':
          print('\n  ¡Hasta pronto! Contactos guardados: ${gestor.total}');
          return; // Terminar el programa
        default:
          print('  Opción inválida. Elige entre 1 y 7.');
      }
    } catch (e) {
      // Capturar errores inesperados sin que la app crashe
      print('  Error inesperado: $e');
      print('  Intenta de nuevo.');
    }
  }
}

// =============================================================================
// ARCHIVO: 02_tipos_nullable.dart
// TEMA: Tipos nullable y operadores básicos de null safety
// =============================================================================
//
// Exploración práctica de String? vs String, int? vs int, y las tres formas
// principales de manejar valores que pueden ser null: if-check, operador ?.,
// operador ?? y operador de aserción !.
//
// CÓMO EJECUTAR:
//   dart run 02_tipos_nullable.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// 1. String vs String? — La diferencia fundamental
// ────────────────────────────────────────────────────────────────────────────

/// Explica la diferencia entre tipos nullable y non-nullable con strings.
void demoStringVsStringNullable() {
  print('── String vs String? ──');

  // String: NUNCA puede ser null — uso directo garantizado
  String nombre = 'Ana';
  print(nombre.toUpperCase()); // Siempre seguro

  // String?: PUEDE ser null — debemos verificar antes de usar
  String? apodo = null;
  String? ciudad = 'Madrid';

  // El compilador NO permite esto directamente:
  // print(apodo.toUpperCase()); // Error: apodo podría ser null

  // Forma correcta: verificar con if
  if (apodo != null) {
    print(apodo.toUpperCase()); // Aquí Dart sabe que NO es null (promotion)
  } else {
    print('Sin apodo registrado');
  }

  // ciudad también es String? pero tiene valor — mismo patrón aplica
  print(ciudad != null ? ciudad.toUpperCase() : 'Sin ciudad');
}

// ────────────────────────────────────────────────────────────────────────────
// 2. int? y double? — Números que pueden no existir
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra tipos numéricos nullable: útiles cuando "sin dato" ≠ 0.
void demoNumerosNullables() {
  print('\n── int? y double? ──');

  // Edad no registrada — null es diferente a 0
  int? edad = null;
  int? puntos = 1500;
  double? calificacion; // Declarada sin valor = null por defecto

  // Verificación antes de operar
  if (edad != null) {
    print('Edad: $edad');
  } else {
    print('Edad no registrada');
  }

  // Con operador ?? para valor por defecto
  int edadMostrar = edad ?? 0;
  print('Edad para mostrar: $edadMostrar');

  // Operar con nullable requiere cuidado
  // int doble = puntos * 2; // Error: puntos podría ser null
  int? doble = puntos != null ? puntos * 2 : null;
  print('Puntos dobles: $doble');

  print('Calificación: ${calificacion ?? "sin calificación"}');
}

// ────────────────────────────────────────────────────────────────────────────
// 3. Operador de acceso seguro: objeto?.propiedad
// ────────────────────────────────────────────────────────────────────────────

/// Clase simple para demostrar el operador ?. en propiedades y métodos.
class Direccion {
  // Calle de la dirección
  final String calle;
  // Número exterior
  final int numero;

  /// Crea una dirección con calle y número.
  const Direccion(this.calle, this.numero);

  /// Devuelve la dirección formateada como "Calle #Número".
  String formatear() => '$calle #$numero';
}

/// Clase que modela un perfil con dirección opcional.
class Perfil {
  // Nombre del perfil
  final String nombre;
  // Dirección: puede no estar registrada
  final Direccion? direccion;

  /// Crea un perfil, la dirección es opcional.
  const Perfil(this.nombre, [this.direccion]);
}

/// Demuestra el uso de ?. para acceder a miembros de objetos que pueden ser null.
void demoAccesoSeguro() {
  print('\n── Operador ?. (acceso seguro) ──');

  Perfil conDir = Perfil('Luis', Direccion('Av. Reforma', 100));
  Perfil sinDir = Perfil('Marta');

  // Sin ?.: habría que usar if(perfil.direccion != null)
  // Con ?.: Dart evalúa la cadena; si encuentra null, devuelve null
  print(conDir.direccion?.formatear()); // 'Av. Reforma #100'
  print(sinDir.direccion?.formatear()); // null (sin crash)

  // Encadenar ?. — si cualquier paso es null, toda la cadena devuelve null
  String? calleMayus = conDir.direccion?.calle.toUpperCase();
  String? calleNull = sinDir.direccion?.calle.toUpperCase();
  print('Calle: $calleMayus');  // AV. REFORMA
  print('Calle: $calleNull');   // null

  // Combinar ?. con ?? para un valor final no-null
  String dirMostrar = sinDir.direccion?.formatear() ?? 'Dirección no registrada';
  print(dirMostrar);
}

// ────────────────────────────────────────────────────────────────────────────
// 4. Operador de coalescencia: valor ?? 'default'
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra el operador ?? para proporcionar valores por defecto.
void demoCoalescencia() {
  print('\n── Operador ?? (coalescencia null) ──');

  String? titulo = null;
  String? descripcion = 'Una app increíble';
  int? version = null;

  // ?? devuelve el lado izquierdo si NO es null, o el derecho si ES null
  print(titulo ?? 'Sin título');         // Sin título
  print(descripcion ?? 'Sin descripción'); // Una app increíble
  print(version ?? 1);                   // 1

  // Se puede encadenar ?? para múltiples fallbacks
  String? a, b;
  String c = 'valor final';
  print(a ?? b ?? c); // valor final (a y b son null, c no)

  // Muy útil en constructores de widgets Flutter:
  // Text(usuario.apodo ?? usuario.nombre ?? 'Anónimo')
}

// ────────────────────────────────────────────────────────────────────────────
// 5. Operador de aserción: valor! (usar con precaución)
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra el operador ! y sus riesgos.
///
/// IMPORTANTE: ! le dice al compilador "confía en mí, esto no es null".
/// Si te equivocas, el programa lanza Null check operator used on a null value
/// en tiempo de ejecución — exactamente lo que queríamos evitar.
void demoAsercionNull() {
  print('\n── Operador ! (aserción non-null) ──');

  String? valor = obtenerValorExterno();

  // Usar ! solo cuando ESTÁS SEGURO de que no es null
  // Aquí sabemos que obtenerValorExterno() siempre devuelve algo
  if (valor != null) {
    // Dentro del if ya es seguro — no necesitas !
    print(valor.toUpperCase());
  }

  // ! es necesario cuando el compilador no puede inferir la seguridad
  String? configuracion = 'produccion';
  // En este caso podemos usar ! porque asignamos el valor arriba
  print('Entorno: ${configuracion!.toUpperCase()}');

  // DEMOSTRACIÓN DEL RIESGO: esto crashea en runtime
  try {
    String? nulo = null;
    String resultado = nulo!; // Lanza: Null check operator used on a null value
    print(resultado);
  } catch (e) {
    print('ERROR al usar !: $e');
    print('Por eso ! debe usarse con extremo cuidado.');
  }
}

/// Simula obtener un valor de una fuente externa que siempre retorna algo.
String? obtenerValorExterno() => 'datos_externos';

void main() {
  demoStringVsStringNullable();
  demoNumerosNullables();
  demoAccesoSeguro();
  demoCoalescencia();
  demoAsercionNull();

  print('\n── Reglas de oro ──');
  print('1. Usa tipos non-nullable siempre que sea posible.');
  print('2. Usa ?. y ?? para manejar nullables elegantemente.');
  print('3. Evita ! a menos que tengas CERTEZA absoluta.');
  print('4. Un if(x != null) activa el type promotion — úsalo.');
}

// EXPERIMENTA:
//   - Crea una función que reciba List<String?> y filtre los null con .whereType<String>()
//   - Prueba qué pasa si encadenas ?. sobre 4 niveles de objetos nullables
//   - Escribe un widget Flutter (en papel) que use ?? para valores opcionales
//   - Reemplaza todos los ! de tu código por if-checks y observa la diferencia

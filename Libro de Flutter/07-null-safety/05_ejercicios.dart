// =============================================================================
// ARCHIVO: 05_ejercicios.dart
// TEMA: Ejercicios de Null Safety
// =============================================================================
//
// Cinco ejercicios prácticos para consolidar el uso de null safety en Dart.
// Cada ejercicio cubre un aspecto diferente: tipos nullables, operadores
// null-aware, type promotion, late, y diseño de APIs null-safe.
//
// CÓMO EJECUTAR:
//   dart run 05_ejercicios.dart
//
// =============================================================================

/// Imprime el encabezado de un ejercicio numerado.
void ejercicio(int n, String titulo) {
  print('\n${'═' * 55}');
  print('EJERCICIO $n: $titulo');
  print('═' * 55);
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1: Normalizar perfil de usuario
// Dado un mapa con datos que pueden ser null, construir un string de perfil
// usando ?? para los valores faltantes.
// ────────────────────────────────────────────────────────────────────────────

/// Construye un resumen legible del perfil de usuario.
///
/// Recibe un [perfil] con claves opcionales y usa ?? para valores por defecto.
/// Retorna un string formateado con los datos disponibles.
String construirResumenPerfil(Map<String, String?> perfil) {
  // Extraer valores con fallbacks usando ??
  String nombre = perfil['nombre'] ?? 'Sin nombre';
  String ciudad = perfil['ciudad'] ?? 'Ciudad desconocida';
  String email = perfil['email'] ?? 'correo no registrado';
  String edad = perfil['edad'] ?? '??';

  return 'Perfil: $nombre, $edad años — $ciudad ($email)';
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2: Cadena de acceso seguro
// Dada una estructura anidada de objetos nullables, extraer un valor
// profundo sin causar NullPointerException.
// ────────────────────────────────────────────────────────────────────────────

/// Modelo de país con nombre.
class Pais {
  // Nombre del país
  final String nombre;
  /// Crea un país con el [nombre] dado.
  const Pais(this.nombre);
}

/// Modelo de ciudad con nombre y país opcional.
class Ciudad {
  // Nombre de la ciudad
  final String nombre;
  // País al que pertenece (puede no estar cargado)
  final Pais? pais;
  /// Crea una ciudad con nombre y país opcional.
  const Ciudad(this.nombre, [this.pais]);
}

/// Modelo de dirección con ciudad opcional.
class Direccion {
  // Ciudad de la dirección (puede no estar cargada)
  final Ciudad? ciudad;
  // Calle de la dirección
  final String calle;
  /// Crea una dirección con calle y ciudad opcional.
  const Direccion(this.calle, [this.ciudad]);
}

/// Extrae el nombre del país de una dirección potencialmente null.
///
/// Si cualquier nivel de la cadena es null, devuelve 'País desconocido'.
String obtenerPais(Direccion? direccion) {
  // Encadenar ?. para navegar la jerarquía de forma segura
  return direccion?.ciudad?.pais?.nombre ?? 'País desconocido';
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3: Type promotion con early return
// Implementar una función que valide un formulario usando el patrón
// de early return para "promover" los tipos de nullable a non-nullable.
// ────────────────────────────────────────────────────────────────────────────

/// Resultado de una validación de formulario.
class ResultadoValidacion {
  // Indica si el formulario es válido
  final bool valido;
  // Mensaje de error o éxito
  final String mensaje;
  /// Crea un resultado de validación.
  const ResultadoValidacion(this.valido, this.mensaje);
}

/// Valida un formulario de registro con campos potencialmente null.
///
/// Usa early return para validar cada campo y type promotion para
/// trabajar con los valores ya verificados.
ResultadoValidacion validarFormulario({
  String? nombre,
  String? email,
  String? contrasena,
  int? edad,
}) {
  // Early return: si nombre es null o vacío, fallar inmediatamente
  if (nombre == null || nombre.trim().isEmpty) {
    return ResultadoValidacion(false, 'El nombre es obligatorio');
  }
  // Aquí 'nombre' es String (promovido) — .trim() sin ?

  if (email == null || !email.contains('@')) {
    return ResultadoValidacion(false, 'Email inválido');
  }
  // Aquí 'email' es String (promovido)

  if (contrasena == null || contrasena.length < 8) {
    return ResultadoValidacion(false, 'La contraseña debe tener al menos 8 caracteres');
  }

  if (edad == null || edad < 18) {
    return ResultadoValidacion(false, 'Debes tener al menos 18 años');
  }
  // Aquí 'edad' es int (promovido)

  // Todos los campos son válidos
  return ResultadoValidacion(
    true,
    'Bienvenido, ${nombre.trim()}! Registro exitoso.',
  );
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 4: Usar ??= para caché simple
// Implementar un servicio de configuración que cargue valores bajo demanda
// usando ??= para almacenarlos en caché.
// ────────────────────────────────────────────────────────────────────────────

/// Servicio de configuración con caché usando ??=.
class ConfiguracionServicio {
  // Caché de configuraciones cargadas bajo demanda
  final Map<String, String> _cache = {};
  // Contador de cargas (para demostrar que no se recarga)
  int _contadorCargas = 0;

  /// Obtiene el valor de [clave], cargándolo si no está en caché.
  String obtener(String clave) {
    // ??= asigna solo si la clave no existe en el mapa
    // Nota: usamos putIfAbsent que es equivalente para Map
    _cache.putIfAbsent(clave, () {
      _contadorCargas++;
      return _cargarDesdeConfig(clave);
    });
    return _cache[clave]!;
  }

  /// Simula cargar una configuración desde una fuente externa.
  String _cargarDesdeConfig(String clave) {
    // Simulación de valores de configuración
    const configs = {
      'idioma': 'es',
      'tema': 'claro',
      'timeout': '30',
    };
    return configs[clave] ?? 'sin_valor';
  }

  /// Devuelve cuántas veces se cargó una configuración desde la fuente.
  int get totalCargas => _contadorCargas;
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 5: Clase con late y validación
// Diseñar una clase que use late para inicialización diferida y maneje
// correctamente el error si se accede antes de inicializar.
// ────────────────────────────────────────────────────────────────────────────

/// Gestor de conexión que verifica si fue inicializado antes de operar.
///
/// Usa un bool para rastrear si fue inicializado y evita el LateInitializationError
/// con un mensaje de error más descriptivo.
class GestorConexion {
  // Conexión activa: se inicializa al conectar
  late final String _urlConexion;
  // Indica si el gestor fue inicializado correctamente
  bool _inicializado = false;

  /// Inicializa la conexión con la [url] dada.
  void conectar(String url) {
    if (_inicializado) {
      print('Ya existe una conexión activa.');
      return;
    }
    _urlConexion = url;
    _inicializado = true;
    print('Conexión establecida: $_urlConexion');
  }

  /// Ejecuta una operación solo si el gestor fue inicializado.
  void ejecutar(String operacion) {
    if (!_inicializado) {
      print('Error: debes llamar conectar() antes de ejecutar operaciones.');
      return;
    }
    print('[$_urlConexion] Ejecutando: $operacion');
  }
}

// ────────────────────────────────────────────────────────────────────────────
// MAIN: Ejecutar todos los ejercicios
// ────────────────────────────────────────────────────────────────────────────

void main() {
  // --- Ejercicio 1 ---
  ejercicio(1, 'Normalizar perfil de usuario');
  print(construirResumenPerfil({
    'nombre': 'Pedro',
    'ciudad': 'Bogotá',
    'email': null,
    'edad': '32',
  }));
  print(construirResumenPerfil({'nombre': null, 'ciudad': null}));

  // --- Ejercicio 2 ---
  ejercicio(2, 'Cadena de acceso seguro');
  Pais mx = Pais('México');
  Ciudad cdmx = Ciudad('CDMX', mx);
  Direccion dir = Direccion('Insurgentes 100', cdmx);
  Direccion dirSinCiudad = Direccion('Calle Desconocida');

  print(obtenerPais(dir));           // México
  print(obtenerPais(dirSinCiudad));  // País desconocido
  print(obtenerPais(null));          // País desconocido

  // --- Ejercicio 3 ---
  ejercicio(3, 'Validación de formulario con type promotion');
  var r1 = validarFormulario(nombre: 'Ana', email: 'ana@test.com',
      contrasena: 'segura123', edad: 25);
  print('${r1.valido}: ${r1.mensaje}');

  var r2 = validarFormulario(nombre: '', email: 'ana@test.com',
      contrasena: 'segura123', edad: 25);
  print('${r2.valido}: ${r2.mensaje}');

  var r3 = validarFormulario(nombre: 'Luis', email: 'invalido',
      contrasena: 'clave', edad: 15);
  print('${r3.valido}: ${r3.mensaje}');

  // --- Ejercicio 4 ---
  ejercicio(4, 'Caché con ??=');
  var config = ConfiguracionServicio();
  print(config.obtener('idioma'));  // es (cargado por primera vez)
  print(config.obtener('tema'));    // claro
  print(config.obtener('idioma')); // es (desde caché, no recarga)
  print('Total cargas desde fuente: ${config.totalCargas}'); // 2

  // --- Ejercicio 5 ---
  ejercicio(5, 'Clase con late y validación de estado');
  GestorConexion gestor = GestorConexion();
  gestor.ejecutar('SELECT 1');      // Error: no inicializado
  gestor.conectar('mysql://localhost:3306/db');
  gestor.ejecutar('SELECT * FROM usuarios'); // Funciona
  gestor.conectar('otra-url');      // Ya inicializado, no cambia

  print('\n¡Todos los ejercicios completados!');
}

// EXPERIMENTA:
//   - Agrega el campo 'telefono' al ejercicio 1 con validación de formato
//   - En el ejercicio 2, agrega un nivel más: Edificio con Apartamentos
//   - En el ejercicio 3, agrega validación de formato de email con RegExp
//   - En el ejercicio 5, agrega un método desconectar() que resetee el estado

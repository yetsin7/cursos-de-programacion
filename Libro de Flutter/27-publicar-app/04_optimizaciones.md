# Optimizaciones para apps Flutter en producción

Una app eficiente es una app que los usuarios retienen. Estas optimizaciones mejoran el rendimiento, reducen el tamaño y facilitan el mantenimiento.

---

## 1. Ofuscación del código Dart

La ofuscación renombra clases, métodos y variables a nombres crípticos, dificultando la ingeniería inversa del APK.

```bash
# Build con ofuscación y mapa de debug separado
flutter build appbundle --release \
  --obfuscate \
  --split-debug-info=build/app/outputs/debug-info/

# El directorio debug-info contendrá archivos .symbols
# GUÁRDALOS junto con el AAB — son necesarios para
# interpretar stack traces de crashes en producción.
```

### ¿Qué hace `--split-debug-info`?

Separa los símbolos de debug del binario principal. Esto:
- Reduce el tamaño del AAB
- Permite decodificar stack traces de Crashlytics/Sentry con los símbolos guardados

```bash
# Decodificar un stack trace ofuscado (en desarrollo)
dart devtools --debug-info=build/app/outputs/debug-info/
```

---

## 2. `const` constructors — la optimización más fácil

Los widgets `const` son construidos **una sola vez** y reutilizados. Flutter no los reconstruye en rebuilds.

```dart
// MAL: reconstruye en cada setState
Column(
  children: [
    Text('Título fijo'),
    Icon(Icons.home),
    SizedBox(height: 16),
  ],
)

// BIEN: no se reconstruyen nunca
const Column(
  children: [
    Text('Título fijo'),
    Icon(Icons.home),
    SizedBox(height: 16),
  ],
)
```

**Regla:** Si un widget no tiene parámetros dinámicos, debe ser `const`.

```bash
# flutter analyze te avisa cuándo falta un const
flutter analyze

# Dart también ofrece el quick-fix automático en VS Code/Android Studio
```

---

## 3. Evitar rebuilds innecesarios

Cada `setState` reconstruye el widget y todos sus hijos. Estrategias para minimizarlo:

### 3.1 Extraer el widget que cambia

```dart
// MAL: todo se reconstruye
class Pantalla extends StatefulWidget {
  @override
  State<Pantalla> createState() => _PantallaState();
}

class _PantallaState extends State<Pantalla> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Este widget NO cambia pero se reconstruye igual
        const ListaEstaticoGrande(),
        // Este SÍ cambia
        Text('$contador'),
        ElevatedButton(
          onPressed: () => setState(() => contador++),
          child: const Text('Incrementar'),
        ),
      ],
    );
  }
}
```

```dart
// BIEN: solo el texto se reconstruye
class _PantallaState extends State<Pantalla> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListaEstaticoGrande(), // const: nunca se reconstruye
        _ContadorWidget(valor: contador),
        ElevatedButton(
          onPressed: () => setState(() => contador++),
          child: const Text('Incrementar'),
        ),
      ],
    );
  }
}
```

### 3.2 Usar `ValueListenableBuilder` para actualizaciones granulares

```dart
// Solo reconstruye el Text, no toda la pantalla
ValueListenableBuilder<int>(
  valueListenable: _contadorNotifier,
  builder: (context, valor, _) => Text('$valor'),
)
```

### 3.3 `RepaintBoundary` para aislar animaciones costosas

```dart
// Aisla la animación para que no cause repaint en los widgets adyacentes
RepaintBoundary(
  child: MiAnimacionCompleja(),
)
```

---

## 4. Lazy loading de listas

Para listas largas (más de 20-30 items), siempre usa `ListView.builder`:

```dart
// MAL: construye TODOS los ítems de una vez
ListView(
  children: miLista.map((item) => ItemWidget(item: item)).toList(),
)

// BIEN: construye solo los visibles en pantalla
ListView.builder(
  itemCount: miLista.length,
  itemBuilder: (context, index) => ItemWidget(miLista[index]),
)
```

---

## 5. Caché de imágenes

```dart
// Flutter cachea imágenes de red automáticamente en memoria.
// Para caché persistente en disco, usar cached_network_image:

// pubspec.yaml:
// cached_network_image: ^3.3.0

CachedNetworkImage(
  imageUrl: 'https://ejemplo.com/imagen.jpg',
  placeholder: (context, url) => const CircularProgressIndicator(),
  errorWidget: (context, url, error) => const Icon(Icons.error),
  // El caché en disco se gestiona automáticamente
)
```

---

## 6. `flutter analyze` y `flutter test` antes de publicar

```bash
# Análisis estático: detecta warnings, errores y lints
flutter analyze

# Ejecutar todos los tests
flutter test

# Test con cobertura de código
flutter test --coverage

# Verificar el tamaño antes de publicar
flutter build appbundle --analyze-size

# Modo perfil: igual que release pero con DevTools activos
flutter run --profile
```

---

## 7. Checklist antes de publicar

```
✅ flutter analyze sin errores
✅ flutter test todo pasa
✅ Versión incrementada en pubspec.yaml
✅ kDebugMode protege todos los logs
✅ No hay keys/secrets hardcoded en el código
✅ Imágenes optimizadas (WebP para assets grandes)
✅ const en todos los widgets estáticos
✅ Build con --obfuscate + --split-debug-info
✅ AAB probado en un dispositivo real
✅ Capturas de pantalla actualizadas si la UI cambió
✅ Novedades de versión escritas en español e inglés
```

---

## 8. Herramientas de monitoreo en producción

| Herramienta | Qué monitorea | Plan gratuito |
|---|---|---|
| Firebase Crashlytics | Crashes en tiempo real | Sí |
| Firebase Performance | Tiempos de carga y red | Sí |
| Firebase Analytics | Comportamiento de usuarios | Sí |
| Sentry | Errores y performance | Sí (5K eventos/mes) |
| Play Console Android Vitals | ANRs, crashes, batería | Sí (incluido) |

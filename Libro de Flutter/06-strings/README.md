# Módulo 06 — Strings en Dart

## ¿Qué es un String?

Un **String** en Dart es una secuencia de unidades de código **UTF-16**. Esto significa que puede representar cualquier carácter Unicode, incluyendo emojis, caracteres acentuados, ideogramas chinos, etc.

## Inmutabilidad

Los Strings en Dart son **inmutables**: una vez creados, no pueden modificarse. Cada operación que "modifica" un string en realidad crea un **nuevo** objeto String en memoria. Esto es importante para el rendimiento: si necesitas construir strings dinámicamente (concatenar muchas partes), usa `StringBuffer`.

## UTF-16 internamente

Dart almacena strings como secuencias de unidades de código de 16 bits (UTF-16). La mayoría de los caracteres comunes ocupan una unidad de código, pero algunos caracteres Unicode especiales (como ciertos emojis o ideogramas raros) ocupan **dos** unidades de código (pares sustitutos). Por eso `string.length` puede no coincidir con el número de caracteres "visibles".

## Tipos de literales String

| Sintaxis | Nombre | Uso |
|---|---|---|
| `'texto'` | Comillas simples | Uso general |
| `"texto"` | Comillas dobles | Uso general |
| `r'texto\n'` | Raw string | Evita secuencias de escape |
| `'''texto'''` | Multilínea simple | Texto en múltiples líneas |
| `"""texto"""` | Multilínea doble | Texto en múltiples líneas |

## Raw Strings

Un raw string (prefijo `r`) trata las barras invertidas como caracteres literales. Es muy útil para expresiones regulares y rutas de archivos en Windows:

```dart
String regex = r'\d+\.\d+';   // Sin raw: '\\d+\\.\\d+'
String ruta  = r'C:\Users\Yetsin\docs';
```

## Strings multilínea

Con triple comilla puedes escribir texto en varias líneas sin `\n` explícitos:

```dart
String poema = '''
  Roses are red,
  Violets are blue.
''';
```

## Interpolación

La interpolación es la forma idiomática de insertar valores en un string:

```dart
String nombre = 'Ana';
print('Hola, $nombre');          // Variable simple
print('Tiene ${nombre.length} letras'); // Expresión
```

## Archivos de este módulo

| Archivo | Contenido |
|---|---|
| `01_strings_basicos.dart` | Creación, tipos, longitud, concatenación |
| `02_interpolacion.dart` | Interpolación simple y de expresiones |
| `03_metodos.dart` | Métodos principales del tipo String |
| `04_ejercicios.dart` | 5 ejercicios prácticos con soluciones |

## Cómo ejecutar

```bash
dart run 01_strings_basicos.dart
dart run 02_interpolacion.dart
dart run 03_metodos.dart
dart run 04_ejercicios.dart
```

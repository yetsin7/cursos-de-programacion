# Capítulo 09 — Manejo de Archivos

Un programa deja de ser temporal cuando puede guardar información y recuperarla después. El manejo
de archivos permite persistir datos, crear reportes, leer configuraciones y compartir información
con otros programas. En C esto se hace de forma explícita usando `FILE *` y funciones de `stdio.h`.

## Qué aprenderás aquí

- Cómo abrir, leer, escribir y cerrar archivos
- Qué significan los modos `r`, `w`, `a`, `rb` y `wb`
- Cómo leer texto línea por línea
- Cuándo usar funciones binarias como `fread` y `fwrite`
- Por qué siempre debes validar errores de entrada y salida

## Qué está pasando dentro del software y del hardware

Cuando tu programa abre un archivo, el sistema operativo le entrega un descriptor o manejador que
representa ese recurso físico o lógico. El puntero `FILE *` es una estructura de la biblioteca
estándar que ayuda a gestionar buffers, posición actual y estado de error.

Cuando escribes, muchas veces los datos no van directo al disco en ese instante. Primero pasan por
buffers en memoria y luego se sincronizan. Por eso cerrar el archivo correctamente es tan
importante.

## Ideas clave del capítulo

### 1. Abrir archivos

```c
FILE *archivo = fopen("datos.txt", "r");
```

Si falla, `fopen` devuelve `NULL`. Siempre debes comprobarlo.

### 2. Modos de apertura

- `"r"`: leer un archivo existente
- `"w"`: escribir desde cero, borrando contenido previo
- `"a"`: agregar al final
- `"rb"` y `"wb"`: leer o escribir en binario

### 3. Leer texto

```c
char linea[256];

while (fgets(linea, sizeof(linea), archivo) != NULL) {
    printf("%s", linea);
}
```

### 4. Escribir texto

```c
fprintf(archivo, "Nombre: %s\n", nombre);
```

### 5. Leer y escribir binario

`fread` y `fwrite` son útiles cuando guardas estructuras o bloques de bytes.

### 6. Cerrar archivos

```c
fclose(archivo);
```

Cerrar libera recursos y asegura que los datos pendientes se vacíen correctamente.

## Situaciones reales donde esto se usa

- Guardar configuraciones
- Exportar reportes
- Leer listas de datos
- Persistir registros sencillos
- Procesar archivos de texto o binarios

## Errores comúnes

- No comprobar si `fopen` devolvió `NULL`
- Olvidar cerrar el archivo
- Leer datos con un formato distinto al que fueron escritos
- Sobrescribir un archivo por abrirlo con `w` cuando querías `a`
- Confiar en `feof` en lugar de verificar el resultado real de lectura

## Cómo estudiar este capítulo

1. Crea un archivo de prueba y escribe varias líneas.
2. Ciérralo y vuelve a abrirlo para leerlo.
3. Prueba diferentes modos de apertura.
4. Genera errores a propósito, como abrir un archivo inexistente en modo lectura.
5. Observa qué pasa cuando olvidas cerrar un archivo.

## Archivos de este capítulo

| Archivo | Descripción |
|---------|-------------|
| `01_archivos.c` | Ejemplos de lectura, escritura y validación de errores en archivos de texto |

## Conexión con el siguiente capítulo

Hasta ahora la memoria de muchos ejemplos ha sido estática o automática. El siguiente capítulo te
mostrará cómo reservar memoria en tiempo de ejecución cuando no sabes de antemano cuánto espacio
necesitarás.

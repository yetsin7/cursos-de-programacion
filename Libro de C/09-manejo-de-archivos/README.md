# Capítulo 09 — Manejo de Archivos

## Archivos en C

C maneja archivos a través de un puntero especial `FILE *`. Todas las operaciones de archivo
están definidas en `<stdio.h>`.

El flujo básico es siempre:
1. **Abrir** el archivo (`fopen`)
2. **Leer o escribir** datos
3. **Cerrar** el archivo (`fclose`)

---

## fopen — Abrir un archivo

```c
FILE *archivo = fopen("datos.txt", "modo");
```

### Modos de apertura

| Modo  | Significado                                               |
|-------|-----------------------------------------------------------|
| `"r"` | Lectura — el archivo debe existir                         |
| `"w"` | Escritura — crea o sobreescribe el archivo                |
| `"a"` | Append — agrega al final sin borrar el contenido          |
| `"r+"`| Lectura y escritura — el archivo debe existir             |
| `"w+"`| Lectura y escritura — crea o sobreescribe                 |
| `"rb"`| Lectura en modo binario                                   |
| `"wb"`| Escritura en modo binario                                 |

```c
FILE *f = fopen("datos.txt", "r");
if (f == NULL) {
    perror("Error al abrir el archivo");
    return 1;
}
```

> Siempre verificar que `fopen` no devuelva `NULL`.

---

## fclose — Cerrar un archivo

```c
fclose(archivo);
```

> Siempre cerrar los archivos para liberar los buffers y el descriptor.

---

## Escribir en archivos

### fprintf — como printf pero hacia un archivo

```c
fprintf(archivo, "Nombre: %s, Edad: %d\n", nombre, edad);
```

### fputs — escribe una línea

```c
fputs("Hola, mundo!\n", archivo);
```

### fwrite — escribe datos binarios

```c
fwrite(&estructura, sizeof(estructura), 1, archivo);
```

---

## Leer de archivos

### fgets — leer una línea

```c
char linea[256];
while (fgets(linea, sizeof(linea), archivo) != NULL) {
    printf("%s", linea);
}
```

### fscanf — como scanf pero desde un archivo

```c
int n;
fscanf(archivo, "%d", &n);
```

### fread — leer datos binarios

```c
fread(&estructura, sizeof(estructura), 1, archivo);
```

---

## Posicionamiento dentro del archivo

```c
fseek(archivo, 0, SEEK_SET);   /* ir al principio */
fseek(archivo, 0, SEEK_END);   /* ir al final */
ftell(archivo);                 /* posición actual en bytes */
rewind(archivo);               /* volver al inicio (como fseek 0 SEEK_SET) */
```

---

## feof — detectar fin de archivo

```c
while (!feof(archivo)) {
    /* leer hasta el final */
}
```

> Preferir verificar el retorno de `fgets` o `fread` en lugar de `feof`.

---

## Eliminar y renombrar archivos

```c
remove("archivo.txt");           /* eliminar */
rename("viejo.txt", "nuevo.txt"); /* renombrar */
```

---

## Archivos de este capítulo

| Archivo          | Descripción                                      |
|------------------|--------------------------------------------------|
| `01_archivos.c`  | Escribir y leer archivos de texto con fprintf/fgets |

---

## Siguiente capítulo

→ **Capítulo 10:** Memoria Dinámica

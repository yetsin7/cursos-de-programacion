# Publicar en Google Play Store

Guía completa para subir tu app Flutter a Google Play, desde la creación de la cuenta hasta la primera publicación y actualizaciones posteriores.

---

## 1. Crear cuenta de desarrollador

1. Ve a [play.google.com/console](https://play.google.com/console)
2. Inicia sesión con tu cuenta de Google
3. Paga la tarifa única de registro: **USD $25**
4. Completa la verificación de identidad (puede tardar 2-3 días)

> La cuenta es de por vida. No hay cuota anual.

---

## 2. Assets necesarios antes de publicar

Prepara todos estos archivos ANTES de crear la ficha en Play Console:

| Asset | Tamaño | Formato | Notas |
|---|---|---|---|
| Ícono de la app | 512 × 512 px | PNG, 32 bits | Sin transparencia |
| Feature graphic | 1024 × 500 px | JPG o PNG | Banner promocional |
| Capturas de pantalla (teléfono) | Mín. 320 dp ancho | JPG o PNG | Mínimo 2, máximo 8 |
| Capturas de tablet 7" | Opcional | JPG o PNG | Recomendado |
| Video promocional | Cualquier duración | URL de YouTube | Opcional |

**Consejos para capturas de pantalla:**
- Usa un dispositivo real o el emulador en resolución alta
- Muestra las funciones principales de la app
- Incluye texto explicativo si es necesario
- Evita marcos de dispositivo (Play los puede agregar automáticamente)

---

## 3. Crear la ficha de la app en Play Console

### Paso a paso:

1. **Crear app:** Play Console → "Crear app" → Nombre, idioma, tipo (app/juego), gratuita/de pago
2. **Configuración de la app:** completar las políticas, declaraciones y clasificación
3. **Ficha de Play Store:** descripción corta (máx. 80 carácteres), descripción larga (máx. 4000), subir assets
4. **Clasificación de contenido:** completar el cuestionario de contenido → recibir clasificación por edades
5. **Público objetivo:** confirmar el rango de edad y si la app está dirigida a niños
6. **Política de privacidad:** URL obligatoria (aunque la app no recopile datos, debes declararlo)

### Descripción de la app — buenas prácticas:
- La **descripción corta** es lo primero que ve el usuario: sé claro y directo
- La **descripción larga** puede usar saltos de línea, listas con guiones y emojis con moderación
- Incluye **palabras clave** naturalmente (no keyword stuffing)
- Escribe versiones en **español e inglés** si tu app soporta ambos idiomas

---

## 4. Subir el AAB

1. Play Console → tu app → **Producción** (o Prueba interna / Alfa / Beta)
2. "Crear versión"
3. Subir el archivo `.aab` desde `build/app/outputs/bundle/release/app-release.aab`
4. Completar las **novedades de la versión** (cambios visibles para el usuario)
5. Revisar la versión y enviar

### ¿APK o AAB?

| | APK | AAB |
|---|---|---|
| Play Store | Solo en producción heredada | **Requerido desde agosto 2021** |
| Distribución directa (sideload) | Sí | No |
| Tamaño de descarga para el usuario | Mayor (APK universal) | Menor (optimizado por dispositivo) |

> Siempre usa **AAB para Google Play** y guarda el APK solo para distribución directa.

---

## 5. Configurar países y precios

- **Países:** Play Console → Precios y distribución → seleccionar países
- Por defecto puedes publicar en todos los países
- Para apps gratuitas no es necesario configurar pagos

---

## 6. Primera publicación

**Tiempos de revisión:**
- Primera publicación: 3-7 días hábiles (revisión manual de Google)
- Actualizaciones: generalmente 2-24 horas (revisión automática + manual si hay cambios de política)

**Posibles rechazos comúnes y cómo evitarlos:**
- Sin política de privacidad: agrega una URL válida aunque sea una página simple
- Ícono con bordes transparentes: debe ser sólido y sin transparencia
- Capturas de pantalla con información de otros (datos personales visibles)
- Descripción que promete funciones no implementadas

---

## 7. Actualizaciones

Para cada actualización:

1. Incrementar `versionCode` en `pubspec.yaml` (ej: de `+1` a `+2`)
2. Actualizar `versionName` si hay cambios significativos (ej: `1.0.1`)
3. Generar nuevo AAB: `flutter build appbundle --release`
4. Play Console → Producción → "Crear versión" → subir nuevo AAB
5. Escribir las novedades de la versión (qué cambió, qué mejoró, qué se corrigió)
6. Enviar para revisión

### Estrategia de lanzamiento gradual (rollout):
En lugar de publicar al 100% de usuarios inmediatamente, puedes hacer un rollout gradual:
- 10% → observar crashes y reseñas → 50% → 100%
- Si hay problemas, puedes pausar o revertir antes de llegar al 100%

---

## 8. Monitoreo post-publicación

Play Console ofrece:
- **Android Vitals:** crashes, ANRs (app no responde), consumo de batería
- **Reseñas:** responder directamente a los usuarios
- **Estadísticas:** instalaciones, retención, calificaciones por versión
- **Firebase Crashlytics** (recomendado): integración para reportes de errores detallados

# Firma de la app Android con Keystore

Toda app publicada en Google Play debe estar firmada con un keystore propio. Esta firma garantiza que las actualizaciones vienen del mismo desarrollador.

> **CRÍTICO:** Si pierdes el keystore, NO puedes actualizar la app en Play Store. Guárdalo en un lugar seguro con respaldo.

---

## 1. Generar el Keystore

Ejecuta este comando en la terminal (requiere JDK instalado):

```bash
keytool -genkey -v \
  -keystore "C:\Users\Yetsin\Documents\Programacion\JDKs para mis Apps\mi_app.keystore" \
  -storetype JKS \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias mi_app_key
```

**Parámetros explicados:**

| Parámetro | Descripción |
|---|---|
| `-keystore` | Ruta donde se guarda el archivo `.keystore` |
| `-storetype JKS` | Formato Java KeyStore (compatible con Android) |
| `-keyalg RSA` | Algoritmo de cifrado (RSA recomendado) |
| `-keysize 2048` | Longitud de la clave (mínimo 2048 bits) |
| `-validity 10000` | Días de validez (~27 años, suficiente para la vida de la app) |
| `-alias` | Nombre interno de la clave dentro del keystore |

El comando pedirá:
- Contraseña del keystore
- Contraseña del alias (puede ser la misma)
- Nombre, organización, ciudad, país (pueden dejarse en blanco)

---

## 2. Crear el archivo `key.properties`

Crea el archivo `android/key.properties` con las credenciales:

```properties
storePassword=tu_contraseña_keystore
keyPassword=tu_contraseña_alias
keyAlias=mi_app_key
storeFile=C:\\Users\\Yetsin\\Documents\\Programacion\\JDKs para mis Apps\\mi_app.keystore
```

> **IMPORTANTE:** Agrega `key.properties` a `.gitignore` para no exponer credenciales:
> ```
> # .gitignore
> android/key.properties
> *.keystore
> *.jks
> ```

---

## 3. Configurar `android/app/build.gradle`

Modifica el archivo para leer `key.properties` y usarlo en el release build:

```groovy
// Al inicio del archivo, ANTES de android { ... }
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    // ... configuración existente ...

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'),
                         'proguard-rules.pro'
        }
    }
}
```

---

## 4. Comandos de build

```bash
# APK firmado para distribución directa (sideload)
flutter build apk --release

# APK por arquitectura (menor tamaño por archivo)
flutter build apk --release --split-per-abi

# AAB para Google Play (formato obligatorio desde agosto 2021)
flutter build appbundle --release

# Con ofuscación Dart adicional
flutter build appbundle --release \
  --obfuscate \
  --split-debug-info=build/app/outputs/debug-info
```

---

## 5. Ubicación de los archivos generados

Todos los outputs de release se guardan en:

```
build/app/outputs/
├── flutter-apk/
│   ├── app-release.apk
│   ├── app-arm64-v8a-release.apk   (con --split-per-abi)
│   └── app-armeabi-v7a-release.apk (con --split-per-abi)
└── bundle/
    └── release/
        └── app-release.aab
```

---

## 6. Verificar la firma del APK

```bash
# Verificar que el APK está correctamente firmado
keytool -printcert -jarfile build/app/outputs/flutter-apk/app-release.apk

# Ver detalles del keystore
keytool -list -v \
  -keystore "C:\Users\Yetsin\Documents\Programacion\JDKs para mis Apps\mi_app.keystore"
```

---

## 7. Play App Signing (recomendado)

Google ofrece **Play App Signing**: Google gestiona el keystore final de producción y tú solo subes el AAB.

**Ventaja:** Si pierdes tu keystore de subida, Google puede reasignarte uno nuevo sin perder la app.

Para habilitarlo: Google Play Console → Configuración de la app → Firma de la app → Activar.

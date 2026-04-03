// ============================================================
// MÓDULO 26 — Uso de i18n con AppLocalizations
// Archivo: 02_uso_l10n.dart
//
// DEPENDENCIAS en pubspec.yaml:
//   dependencies:
//     flutter_localizations:
//       sdk: flutter
//     intl: ^0.19.0
//   flutter:
//     generate: true
//
// Conceptos:
//   - MaterialApp con localizationsDelegates y supportedLocales
//   - Cambiar el idioma manualmente con estado
//   - Plurales y parámetros dinámicos en ARB
//   - Detectar el locale del sistema
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Descomentar tras ejecutar `flutter gen-l10n`:
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(const AppI18n());

/// Gestiona el locale activo. Notifica al árbol cuando cambia
/// para que MaterialApp se reconstruya con el nuevo idioma.
class EstadoIdioma extends ChangeNotifier {
  Locale _locale = const Locale('es');
  Locale get locale => _locale;

  /// Cambia el idioma y notifica a los oyentes.
  void cambiar(Locale nueva) {
    if (_locale != nueva) {
      _locale = nueva;
      notifyListeners();
    }
  }
}

/// Raíz de la app. Reconstruye MaterialApp cuando cambia el idioma.
class AppI18n extends StatefulWidget {
  const AppI18n({super.key});

  @override
  State<AppI18n> createState() => _AppI18nState();
}

class _AppI18nState extends State<AppI18n> {
  final EstadoIdioma _estado = EstadoIdioma();

  @override
  void initState() {
    super.initState();
    _estado.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _estado.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true),
      locale: _estado.locale,
      localizationsDelegates: const [
        // AppLocalizations.delegate, // Descomentar con gen-l10n
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es'), Locale('en')],
      home: PantallaDemo(estado: _estado),
    );
  }
}

/// Pantalla principal que demuestra el cambio de idioma, plurales y locale del sistema.
class PantallaDemo extends StatefulWidget {
  final EstadoIdioma estado;
  const PantallaDemo({super.key, required this.estado});

  @override
  State<PantallaDemo> createState() => _PantallaDemoState();
}

class _PantallaDemoState extends State<PantallaDemo> {
  int _contador = 0;

  /// Traducciones simuladas. Reemplazar con AppLocalizations.of(context)!.clave
  String _t(String k) {
    final es = widget.estado.locale.languageCode == 'es';
    return {
      'titulo':    es ? 'Demostración i18n'            : 'i18n Demo',
      'saludo':    es ? 'Hola, bienvenido'             : 'Hello, welcome',
      'desc':      es ? 'App con español e inglés'     : 'App with Spanish and English',
      'idioma':    es ? 'Cambiar idioma'               : 'Change language',
      'contador':  es ? 'Contador'                     : 'Counter',
      'sumar':     es ? 'Sumar'                        : 'Add',
      'resetear':  es ? 'Resetear'                     : 'Reset',
      'sistema':   es ? 'Locale del sistema'           : 'System locale',
    }[k] ?? k;
  }

  /// Plural básico. En ARB real: {n, plural, =0{...} =1{...} other{...}}
  String _plural(int n) {
    final es = widget.estado.locale.languageCode == 'es';
    if (n == 0) return es ? 'Sin elementos' : 'No items';
    if (n == 1) return es ? '1 elemento'    : '1 item';
    return       es ? '$n elementos'        : '$n items';
  }

  @override
  Widget build(BuildContext context) {
    final sysLocale = WidgetsBinding.instance.platformDispatcher.locale;
    return Scaffold(
      appBar: AppBar(
        title: Text(_t('titulo')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Text(widget.estado.locale.languageCode == 'es' ? '🇺🇸' : '🇪🇸',
                style: const TextStyle(fontSize: 22)),
            tooltip: _t('idioma'),
            onPressed: () => widget.estado.cambiar(
              Locale(widget.estado.locale.languageCode == 'es' ? 'en' : 'es')),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Tarjeta de saludo
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_t('saludo'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(_t('desc')),
            ],
          ))),
          const SizedBox(height: 12),

          // Selector de idioma
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_t('idioma'), style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(children: [
                _btnIdioma('es', '🇪🇸 Español'),
                const SizedBox(width: 10),
                _btnIdioma('en', '🇺🇸 English'),
              ]),
            ],
          ))),
          const SizedBox(height: 12),

          // Contador con plural
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_t('contador'), style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(_plural(_contador),
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal)),
              const SizedBox(height: 10),
              Row(children: [
                ElevatedButton(onPressed: () => setState(() => _contador++), child: Text(_t('sumar'))),
                const SizedBox(width: 8),
                TextButton(onPressed: () => setState(() => _contador = 0), child: Text(_t('resetear'))),
              ]),
            ],
          ))),
          const SizedBox(height: 12),

          // Información del locale del sistema
          Card(color: Colors.amber.shade50, child: Padding(padding: const EdgeInsets.all(16), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_t('sistema'), style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('languageCode: ${sysLocale.languageCode}'),
              Text('countryCode: ${sysLocale.countryCode ?? "no definido"}'),
              Text('App activa: ${widget.estado.locale.languageCode}'),
            ],
          ))),
          const SizedBox(height: 12),

          // Bloque de código de referencia
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(8)),
            child: const Text(
              '// En producción:\n'
              'Text(AppLocalizations.of(context)!.saludo)\n\n'
              '// Con parámetro:\n'
              'Text(AppLocalizations.of(context)!.bienvenido("Ana"))\n\n'
              '// Plural (definido en ARB):\n'
              'Text(AppLocalizations.of(context)!.elementos(3))',
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFCCCCCC)),
            ),
          ),
        ],
      ),
    );
  }

  /// Botón para seleccionar un idioma, resaltado si está activo.
  Widget _btnIdioma(String codigo, String etiqueta) {
    final activo = widget.estado.locale.languageCode == codigo;
    return ElevatedButton(
      onPressed: () => widget.estado.cambiar(Locale(codigo)),
      style: ElevatedButton.styleFrom(
        backgroundColor: activo ? Colors.teal : null,
        foregroundColor: activo ? Colors.white : null,
      ),
      child: Text(etiqueta),
    );
  }
}

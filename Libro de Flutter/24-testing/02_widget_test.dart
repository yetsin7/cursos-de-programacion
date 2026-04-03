// =============================================================================
// ARCHIVO: 02_widget_test.dart
// TEMA: Widget Tests en Flutter — testear la UI e interacciones
// =============================================================================
// CÓMO USAR: guardar en test/02_widget_test.dart y ejecutar: flutter test
// DEPENDENCIA: flutter_test ya viene incluido en Flutter SDK
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// =============================================================================
// WIDGETS A TESTEAR — en una app real estarían en lib/
// =============================================================================

/// Widget de contador simple para demostrar widget tests.
class WidgetContador extends StatefulWidget {
  final int valorInicial;
  const WidgetContador({super.key, this.valorInicial = 0});

  @override
  State<WidgetContador> createState() => _WidgetContadorState();
}

class _WidgetContadorState extends State<WidgetContador> {
  late int _contador;

  @override
  void initState() {
    super.initState();
    _contador = widget.valorInicial;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contador')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Clave para encontrar el widget en los tests
            Text('$_contador', key: const Key('texto-contador'),
                style: const TextStyle(fontSize: 48)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  key: const Key('boton-decrementar'),
                  onPressed: _contador > 0
                      ? () => setState(() => _contador--)
                      : null,
                  child: const Text('-'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  key: const Key('boton-incrementar'),
                  onPressed: () => setState(() => _contador++),
                  child: const Text('+'),
                ),
              ],
            ),
            if (_contador >= 10)
              const Text('Máximo recomendado alcanzado',
                  key: Key('texto-aviso')),
          ],
        ),
      ),
    );
  }
}

/// Formulario de login simple para testear entrada de texto.
class FormularioLogin extends StatefulWidget {
  final Future<bool> Function(String email, String password) onLogin;
  const FormularioLogin({super.key, required this.onLogin});

  @override
  State<FormularioLogin> createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _cargando = false;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _cargando = true);

    final exito = await widget.onLogin(_emailCtrl.text, _passwordCtrl.text);

    if (mounted) {
      setState(() {
        _cargando = false;
        _error = exito ? null : 'Credenciales incorrectas';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                key: const Key('campo-email'),
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) =>
                    (v == null || !v.contains('@')) ? 'Email inválido' : null,
              ),
              TextFormField(
                key: const Key('campo-password'),
                controller: _passwordCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                validator: (v) =>
                    (v == null || v.length < 6) ? 'Mínimo 6 caracteres' : null,
              ),
              const SizedBox(height: 16),
              if (_error != null)
                Text(_error!, key: const Key('texto-error'),
                    style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                key: const Key('boton-login'),
                onPressed: _cargando ? null : _enviar,
                child: _cargando
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// WIDGET TESTS
// =============================================================================

void main() {
  // ─── Tests del Contador ───────────────────────────────────────────────────────
  group('WidgetContador', () {
    testWidgets('muestra el valor inicial 0', (WidgetTester tester) async {
      // pumpWidget() renderiza el widget en el entorno de test
      await tester.pumpWidget(
        const MaterialApp(home: WidgetContador()),
      );

      // find.byKey() busca por Key — más estable que find.text() para valores dinámicos
      expect(find.byKey(const Key('texto-contador')), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('muestra valor inicial personalizado', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: WidgetContador(valorInicial: 5)),
      );
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('incrementar aumenta el contador', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: WidgetContador()),
      );

      // tap() simula un toque en el widget encontrado
      await tester.tap(find.byKey(const Key('boton-incrementar')));
      // pump() procesa los eventos pendientes y reconstruye el árbol
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('no puede decrementar por debajo de 0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: WidgetContador()),
      );

      // El botón decrementar debe estar deshabilitado en 0
      final boton = tester.widget<ElevatedButton>(
        find.byKey(const Key('boton-decrementar')),
      );
      expect(boton.onPressed, isNull); // onPressed null = deshabilitado
    });

    testWidgets('muestra aviso al llegar a 10', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: WidgetContador(valorInicial: 9)),
      );

      // El aviso no debe mostrarse en 9
      expect(find.byKey(const Key('texto-aviso')), findsNothing);

      await tester.tap(find.byKey(const Key('boton-incrementar')));
      await tester.pump();

      // El aviso debe mostrarse al llegar a 10
      expect(find.byKey(const Key('texto-aviso')), findsOneWidget);
    });

    testWidgets('múltiples incrementos', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: WidgetContador()),
      );

      // Simular 3 toques
      for (int i = 0; i < 3; i++) {
        await tester.tap(find.byKey(const Key('boton-incrementar')));
        await tester.pump();
      }

      expect(find.text('3'), findsOneWidget);
    });
  });

  // ─── Tests del FormularioLogin ─────────────────────────────────────────────────
  group('FormularioLogin', () {
    testWidgets('muestra los campos y el botón', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FormularioLogin(onLogin: (_, __) async => true),
        ),
      );

      expect(find.byKey(const Key('campo-email')), findsOneWidget);
      expect(find.byKey(const Key('campo-password')), findsOneWidget);
      expect(find.byKey(const Key('boton-login')), findsOneWidget);
    });

    testWidgets('muestra error de validación con email inválido', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FormularioLogin(onLogin: (_, __) async => true),
        ),
      );

      // enterText() simula que el usuario escribe texto
      await tester.enterText(find.byKey(const Key('campo-email')), 'correosinAt');
      await tester.enterText(
          find.byKey(const Key('campo-password')), 'password123');

      await tester.tap(find.byKey(const Key('boton-login')));
      await tester.pump(); // Procesar el tap

      // Verificar que el mensaje de validación aparece
      expect(find.text('Email inválido'), findsOneWidget);
    });

    testWidgets('login fallido muestra mensaje de error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FormularioLogin(
            // Simular login fallido
            onLogin: (_, __) async => false,
          ),
        ),
      );

      await tester.enterText(
          find.byKey(const Key('campo-email')), 'user@test.com');
      await tester.enterText(
          find.byKey(const Key('campo-password')), 'password123');

      await tester.tap(find.byKey(const Key('boton-login')));
      // pumpAndSettle() espera hasta que no haya más animaciones pendientes
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('texto-error')), findsOneWidget);
      expect(find.text('Credenciales incorrectas'), findsOneWidget);
    });

    testWidgets('login exitoso no muestra error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FormularioLogin(
            onLogin: (_, __) async => true,
          ),
        ),
      );

      await tester.enterText(
          find.byKey(const Key('campo-email')), 'user@test.com');
      await tester.enterText(
          find.byKey(const Key('campo-password')), 'password123');

      await tester.tap(find.byKey(const Key('boton-login')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('texto-error')), findsNothing);
    });

    testWidgets('find.byType encuentra widgets por tipo', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FormularioLogin(onLogin: (_, __) async => true),
        ),
      );

      // find.byType busca todos los widgets de un tipo específico
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}

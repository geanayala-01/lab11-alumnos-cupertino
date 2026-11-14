import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

import '../data/datos.dart';
import '../theme/app_theme.dart';
import '../widgets/campo_texto.dart';

/// 4. REGISTRAR ALUMNO. Si llega un alumno por argumento, la misma
/// pantalla sirve para editarlo.
class RegistrarAlumnoScreen extends StatefulWidget {
  const RegistrarAlumnoScreen({super.key});

  @override
  State<RegistrarAlumnoScreen> createState() => _RegistrarAlumnoScreenState();
}

class _RegistrarAlumnoScreenState extends State<RegistrarAlumnoScreen> {
  final _nombre = TextEditingController();
  final _apellido = TextEditingController();
  final _nota = TextEditingController();
  Map<String, dynamic>? _editando;
  bool _leido = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Los argumentos de la ruta no se pueden leer en initState (todavía no
    // hay context completo), por eso se leen aquí y solo la primera vez.
    if (_leido) return;
    _leido = true;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _editando = args;
      _nombre.text = args['nombre'];
      _apellido.text = args['apellido'];
      _nota.text = '${args['nota']}';
    }
  }

  @override
  void dispose() {
    _nombre.dispose();
    _apellido.dispose();
    _nota.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    final nombre = _nombre.text.trim();
    final apellido = _apellido.text.trim();
    // int.tryParse devuelve null si el texto no es un número (no lanza error)
    final nota = int.tryParse(_nota.text.trim());

    if (nombre.isEmpty || apellido.isEmpty) {
      return alerta(context, 'Faltan datos', 'Completa el nombre y el apellido.');
    }
    if (nota == null || nota < 0 || nota > 20) {
      return alerta(context, 'Nota inválida', 'La nota debe ser un número de 0 a 20.');
    }

    final alumno = {'nombre': nombre, 'apellido': apellido, 'nota': nota};
    _editando == null ? agregarAlumno(alumno) : reemplazarAlumno(_editando!, alumno);

    await alerta(context, _editando == null ? 'Alumno registrado' : 'Alumno actualizado',
        '$nombre $apellido – Nota: ${'$nota'.padLeft(2, '0')}');
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // Barra morada fija (sin esto iOS la deja transparente hasta hacer scroll)
        backgroundColor: AppTheme.morado,
        automaticBackgroundVisibility: false,
        leading: const CupertinoNavigationBarBackButton(color: CupertinoColors.white),
        middle: Text(_editando == null ? 'Registrar Alumno' : 'Editar Alumno'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            CampoTexto(controller: _nombre, placeholder: 'Nombre del alumno'),
            const SizedBox(height: 14),
            CampoTexto(controller: _apellido, placeholder: 'Apellido'),
            const SizedBox(height: 14),
            CampoTexto(
              controller: _nota,
              placeholder: 'Nota (0 - 20)',
              teclado: TextInputType.number,
              sufijo: const Icon(Icons.school, color: AppTheme.gris, size: 22),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton.filled(
                onPressed: _guardar,
                child: const Text('GUARDAR',
                    style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

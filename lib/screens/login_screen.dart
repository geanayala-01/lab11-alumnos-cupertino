import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

import '../data/datos.dart';
import '../theme/app_theme.dart';
import '../widgets/campo_texto.dart';

/// 1. LOGIN: valida el email y la contraseña contra el Map "usuario".
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _oculto = true; // controla el "ojito" de la contraseña
  bool _cargando = false;

  @override
  void dispose() {
    // Los controllers se liberan para no dejar memoria ocupada
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _email.text.trim();
    if (email.isEmpty || _password.text.isEmpty) {
      return alerta(context, 'Faltan datos', 'Ingresa tu email y contraseña.');
    }
    if (!email.contains('@')) {
      return alerta(context, 'Email inválido', 'Revisa el formato del email.');
    }
    // Simula la espera de un servidor mostrando el indicador de iOS
    setState(() => _cargando = true);
    await Future.delayed(const Duration(milliseconds: 700));
    // "mounted" evita usar el context si la pantalla ya se cerró durante la espera
    if (!mounted) return;
    setState(() => _cargando = false);

    if (email == usuario['email'] && _password.text == usuario['password']) {
      // pushReplacementNamed: el login sale de la pila, así "atrás" no regresa aquí
      Navigator.pushReplacementNamed(context, '/menu');
    } else {
      alerta(context, 'Error', 'Email o contraseña incorrectos.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            children: [
              const Icon(Icons.school, size: 72, color: AppTheme.morado),
              const SizedBox(height: 12),
              const Text(
                'Iniciar Sesión',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Ingresa tus credenciales para continuar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: AppTheme.gris),
              ),
              const SizedBox(height: 28),
              CampoTexto(
                controller: _email,
                placeholder: 'Email',
                icono: CupertinoIcons.mail,
                teclado: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),
              CampoTexto(
                controller: _password,
                placeholder: 'Password',
                icono: CupertinoIcons.lock,
                oculto: _oculto,
                sufijo: CupertinoButton(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(32, 32),
                  onPressed: () => setState(() => _oculto = !_oculto),
                  child: Icon(
                    _oculto ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    color: AppTheme.gris,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: _cargando ? null : _login,
                  child: _cargando
                      ? const CupertinoActivityIndicator(color: CupertinoColors.white)
                      : const Text('LOGIN',
                          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1)),
                ),
              ),
              CupertinoButton(
                onPressed: () => alerta(context, 'Recuperar contraseña',
                    'Te enviaremos un enlace a ${_email.text.isEmpty ? 'tu email' : _email.text}.'),
                child: const Text('¿Olvidaste tu contraseña?',
                    style: TextStyle(fontSize: 14, color: AppTheme.gris)),
              ),
              const SizedBox(height: 8),
              Text(
                'Usuario de prueba: ${usuario['email']} · ${usuario['password']}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: AppTheme.gris),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

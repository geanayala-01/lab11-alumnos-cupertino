import 'package:flutter/cupertino.dart';

import 'screens/login_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/alumnos_screen.dart';
import 'screens/registrar_alumno_screen.dart';
import 'screens/perfil_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const Lab11App());

class Lab11App extends StatelessWidget {
  const Lab11App({super.key});

  @override
  Widget build(BuildContext context) {
    // CupertinoApp en lugar de MaterialApp: toda la app usa el diseño de iOS
    // y las rutas se abren con CupertinoPageRoute (se puede deslizar desde
    // el borde izquierdo para volver).
    return CupertinoApp(
      title: 'Lab 11 - Alumnos',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.tema, // Tema global
      initialRoute: '/login',
      // Rutas con nombre
      routes: {
        '/login': (context) => const LoginScreen(),
        '/menu': (context) => const MenuScreen(),
        '/alumnos': (context) => const AlumnosScreen(),
        '/registrar': (context) => const RegistrarAlumnoScreen(),
        '/perfil': (context) => const PerfilScreen(),
      },
    );
  }
}

import 'package:flutter/cupertino.dart';

import '../data/datos.dart';
import '../theme/app_theme.dart';

/// 2. MENÚ: opciones en una lista agrupada de iOS (CupertinoListTile).
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  // Opciones del menú como Lista de Maps (texto, ícono y ruta)
  static const List<Map<String, dynamic>> opciones = [
    {'texto': 'Registrar Alumnos', 'icono': CupertinoIcons.person_badge_plus_fill, 'ruta': '/registrar'},
    {'texto': 'Listar Alumnos', 'icono': CupertinoIcons.list_bullet, 'ruta': '/alumnos'},
    {'texto': 'Perfil', 'icono': CupertinoIcons.person_fill, 'ruta': '/perfil'},
  ];

  void _logout(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Seguro que quieres salir?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(dialogContext);
              // Borra toda la pila de rutas y vuelve al login
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            child: const Text('Salir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        // Barra morada fija (sin esto iOS la deja transparente hasta hacer scroll)
        backgroundColor: AppTheme.morado,
        automaticBackgroundVisibility: false,
        automaticallyImplyLeading: false,
        leading: Icon(CupertinoIcons.line_horizontal_3, color: CupertinoColors.white),
        middle: Text('Menú'),
      ),
      child: ListView(
        children: [
          // Card de bienvenida con el resumen de notas
          ValueListenableBuilder(
            valueListenable: alumnos,
            builder: (context, lista, _) {
              final aprobados = lista.where(aprobado).length;
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                padding: const EdgeInsets.all(16),
                decoration: AppTheme.tarjeta(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hola, ${usuario['nombre']!.split(' ').first} 👋',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _dato('${lista.length}', 'Alumnos', AppTheme.morado),
                        _dato('$aprobados', 'Aprobados', AppTheme.verde),
                        _dato('${lista.length - aprobados}', 'Desaprobados', AppTheme.rojo),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          CupertinoListSection.insetGrouped(
            children: [
              ...opciones.map((o) => CupertinoListTile.notched(
                    leading: Icon(o['icono'], color: AppTheme.morado),
                    title: Text(o['texto']),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () => Navigator.pushNamed(context, o['ruta']),
                  )),
              CupertinoListTile.notched(
                leading: const Icon(CupertinoIcons.square_arrow_right,
                    color: AppTheme.rojo),
                title: const Text('Logout'),
                trailing: const CupertinoListTileChevron(),
                onTap: () => _logout(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dato(String valor, String texto, Color color) => Expanded(
        child: Column(
          children: [
            Text(valor,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            Text(texto, style: const TextStyle(fontSize: 12, color: AppTheme.gris)),
          ],
        ),
      );
}

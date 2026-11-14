import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

import '../theme/app_theme.dart';

/// Avatar circular con el birrete. Se usa en la lista de alumnos.
/// (Icons.school viene de Material porque CupertinoIcons no tiene birrete.)
class AvatarAlumno extends StatelessWidget {
  final double tamano;
  final bool desaprobado;

  const AvatarAlumno({super.key, this.tamano = 44, this.desaprobado = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: desaprobado ? const Color(0xFFFDE8E8) : AppTheme.moradoClaro,
      ),
      child: Icon(Icons.school,
          size: tamano * 0.55,
          color: desaprobado ? AppTheme.rojo : AppTheme.morado),
    );
  }
}

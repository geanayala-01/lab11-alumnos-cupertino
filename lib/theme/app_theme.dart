import 'package:flutter/cupertino.dart';

/// Tema global de la app (Sección A: color morado).
/// Se usa CupertinoThemeData en vez de ThemeData porque la app es CupertinoApp.
class AppTheme {
  static const morado = Color(0xFF5B47D6);
  static const moradoClaro = Color(0xFFEDEAFB);
  static const fondo = Color(0xFFF4F4F8);
  static const texto = Color(0xFF1C1C1E);
  static const gris = CupertinoColors.systemGrey;
  static const verde = Color(0xFF1E9E4A);
  static const rojo = Color(0xFFE0383E);

  static CupertinoThemeData get tema => const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: morado,
        primaryContrastingColor: CupertinoColors.white,
        scaffoldBackgroundColor: fondo,
        barBackgroundColor: morado, // barras de navegación moradas como en el diseño
        textTheme: CupertinoTextThemeData(
          primaryColor: morado,
          textStyle: TextStyle(fontSize: 16, color: texto),
          // Título de la barra en blanco porque la barra es morada
          navTitleTextStyle: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: CupertinoColors.white),
          navActionTextStyle: TextStyle(fontSize: 17, color: CupertinoColors.white),
        ),
      );

  /// Estilo de "card": Cupertino no trae el widget Card, así que se arma
  /// con un BoxDecoration (fondo blanco, bordes redondeados y sombra suave).
  static BoxDecoration tarjeta({double radio = 14}) => BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(radio),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 3)),
        ],
      );
}

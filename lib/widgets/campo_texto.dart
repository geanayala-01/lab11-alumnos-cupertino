import 'package:flutter/cupertino.dart';

import '../theme/app_theme.dart';

/// Campo de texto reutilizable con borde gris y bordes redondeados.
/// CupertinoTextField no trae "label" como el TextField de Material,
/// por eso se usa placeholder + íconos en prefix / suffix.
class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final IconData? icono;
  final Widget? sufijo;
  final bool oculto;
  final TextInputType? teclado;

  const CampoTexto({
    super.key,
    required this.controller,
    required this.placeholder,
    this.icono,
    this.sufijo,
    this.oculto = false,
    this.teclado,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      obscureText: oculto,
      keyboardType: teclado,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      prefix: icono == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Icon(icono, color: AppTheme.gris, size: 20),
            ),
      suffix: sufijo == null
          ? null
          : Padding(padding: const EdgeInsets.only(right: 8), child: sufijo),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        border: Border.all(color: const Color(0xFFD9D9E0)),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

/// Muestra una alerta simple de iOS con un solo botón "OK".
Future<void> alerta(BuildContext context, String titulo, String mensaje) {
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(titulo),
      content: Text(mensaje),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

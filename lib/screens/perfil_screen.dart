import 'package:flutter/cupertino.dart';

import '../data/datos.dart';
import '../theme/app_theme.dart';
import '../widgets/campo_texto.dart';

/// 5. PERFIL: datos del usuario (Map) en una lista agrupada de iOS.
class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  /// Abre una hoja desde abajo (modal de iOS) para editar nombre y teléfono.
  void _editar() {
    final nombre = TextEditingController(text: usuario['nombre']);
    final telefono = TextEditingController(text: usuario['telefono']);

    showCupertinoModalPopup(
      context: context,
      builder: (sheetContext) => Padding(
        // Sube la hoja cuando aparece el teclado
        padding: EdgeInsets.only(bottom: MediaQuery.of(sheetContext).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 34),
          decoration: const BoxDecoration(
            color: AppTheme.fondo,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Editar perfil',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.texto,
                      decoration: TextDecoration.none)),
              const SizedBox(height: 16),
              CampoTexto(controller: nombre, placeholder: 'Nombre', icono: CupertinoIcons.person),
              const SizedBox(height: 12),
              CampoTexto(
                controller: telefono,
                placeholder: 'Teléfono',
                icono: CupertinoIcons.phone,
                teclado: TextInputType.phone,
              ),
              const SizedBox(height: 18),
              CupertinoButton.filled(
                onPressed: () {
                  setState(() {
                    usuario['nombre'] = nombre.text.trim();
                    usuario['telefono'] = telefono.text.trim();
                  });
                  Navigator.pop(sheetContext);
                },
                child: const Text('GUARDAR'),
              ),
              CupertinoButton(
                onPressed: () => Navigator.pop(sheetContext),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Lista de Maps con las filas del perfil
    final filas = [
      {'icono': CupertinoIcons.person_fill, 'campo': 'Nombre', 'valor': usuario['nombre']},
      {'icono': CupertinoIcons.mail_solid, 'campo': 'Email', 'valor': usuario['email']},
      {'icono': CupertinoIcons.phone_fill, 'campo': 'Teléfono', 'valor': usuario['telefono']},
      {'icono': CupertinoIcons.gear_solid, 'campo': 'Roles', 'valor': usuario['rol']},
    ];

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        // Barra morada fija (sin esto iOS la deja transparente hasta hacer scroll)
        backgroundColor: AppTheme.morado,
        automaticBackgroundVisibility: false,
        leading: CupertinoNavigationBarBackButton(color: CupertinoColors.white),
        middle: Text('Perfil'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: [
            Center(
              // Stack para poner el botón del lápiz encima del avatar
              child: Stack(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppTheme.moradoClaro),
                    child: const Icon(CupertinoIcons.person_fill,
                        size: 64, color: AppTheme.morado),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: GestureDetector(
                      onTap: _editar,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: AppTheme.morado,
                          shape: BoxShape.circle,
                          border: Border.all(color: CupertinoColors.white, width: 2),
                        ),
                        child: const Icon(CupertinoIcons.pencil,
                            size: 16, color: CupertinoColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(usuario['nombre']!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(usuario['email']!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: AppTheme.gris)),
            CupertinoListSection.insetGrouped(
              children: filas
                  .map((f) => CupertinoListTile(
                        leading: Icon(f['icono'] as IconData, color: AppTheme.gris),
                        title: Text(f['campo'] as String),
                        additionalInfo: Text(f['valor'] as String),
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // Botón con borde (Cupertino no tiene OutlinedButton)
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.morado, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CupertinoButton(
                  onPressed: _editar,
                  child: const Text('EDITAR PERFIL',
                      style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

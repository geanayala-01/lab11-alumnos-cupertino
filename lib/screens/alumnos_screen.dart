import 'package:flutter/cupertino.dart';

import '../data/datos.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar.dart';

/// 3. LISTAR ALUMNOS: buscador, filtro y ListView.builder de cards.
class AlumnosScreen extends StatefulWidget {
  const AlumnosScreen({super.key});

  @override
  State<AlumnosScreen> createState() => _AlumnosScreenState();
}

class _AlumnosScreenState extends State<AlumnosScreen> {
  String _busqueda = '';
  String _filtro = 'todos';

  /// Aplica el buscador y el filtro del control segmentado.
  List<Map<String, dynamic>> _filtrar(List<Map<String, dynamic>> lista) {
    return lista.where((a) {
      final coincide =
          nombreCompleto(a).toLowerCase().contains(_busqueda.toLowerCase());
      final pasaFiltro = switch (_filtro) {
        'aprobados' => aprobado(a),
        'desaprobados' => !aprobado(a),
        _ => true,
      };
      return coincide && pasaFiltro;
    }).toList();
  }

  /// Hoja de acciones de iOS que aparece al tocar los tres puntos.
  void _opciones(Map<String, dynamic> a) {
    showCupertinoModalPopup(
      context: context,
      builder: (sheetContext) => CupertinoActionSheet(
        title: Text(nombreCompleto(a)),
        message: Text('Nota: ${notaTexto(a)}'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(sheetContext);
              // Se reutiliza la ruta /registrar pasando el alumno como argumento
              Navigator.pushNamed(context, '/registrar', arguments: a);
            },
            child: const Text('Editar'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(sheetContext);
              _confirmarEliminar(a);
            },
            child: const Text('Eliminar'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(sheetContext),
          child: const Text('Cancelar'),
        ),
      ),
    );
  }

  void _confirmarEliminar(Map<String, dynamic> a) {
    showCupertinoDialog(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('Eliminar alumno'),
        content: Text('¿Eliminar a ${nombreCompleto(a)}?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              eliminarAlumno(a);
              Navigator.pop(dialogContext);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // Barra morada fija (sin esto iOS la deja transparente hasta hacer scroll)
        backgroundColor: AppTheme.morado,
        automaticBackgroundVisibility: false,
        automaticallyImplyLeading: false,
        // El ícono de menú regresa a la pantalla Menú
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.line_horizontal_3,
              color: CupertinoColors.white),
        ),
        middle: const Text('Alumnos'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pushNamed(context, '/registrar'),
          child: const Icon(CupertinoIcons.add, color: CupertinoColors.white),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              child: CupertinoSearchTextField(
                placeholder: 'Buscar alumno...',
                backgroundColor: CupertinoColors.white,
                onChanged: (v) => setState(() => _busqueda = v),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<String>(
                  groupValue: _filtro,
                  onValueChanged: (v) => setState(() => _filtro = v!),
                  children: const {
                    'todos': Text('Todos'),
                    'aprobados': Text('Aprobados'),
                    'desaprobados': Text('Desaprobados'),
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Se redibuja solo cuando cambia la lista de alumnos
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: alumnos,
                builder: (context, lista, _) {
                  final filtrados = _filtrar(lista);
                  if (filtrados.isEmpty) {
                    return const Center(
                      child: Text('No hay alumnos',
                          style: TextStyle(color: AppTheme.gris)),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                    itemCount: filtrados.length,
                    itemBuilder: (context, i) => _tarjeta(filtrados[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Card de cada alumno con un CupertinoListTile adentro.
  Widget _tarjeta(Map<String, dynamic> a) {
    final ok = aprobado(a);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: AppTheme.tarjeta(),
      clipBehavior: Clip.antiAlias,
      child: CupertinoListTile(
        padding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
        leadingSize: 44,
        leading: AvatarAlumno(desaprobado: !ok),
        title: Text(nombreCompleto(a),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('Nota: ${notaTexto(a)}'),
        additionalInfo: _etiqueta(ok),
        trailing: CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          onPressed: () => _opciones(a),
          child: const Icon(CupertinoIcons.ellipsis_vertical, color: AppTheme.gris),
        ),
        onTap: () => Navigator.pushNamed(context, '/registrar', arguments: a),
      ),
    );
  }

  /// Etiqueta verde (Aprobado) o roja (Desaprobado).
  Widget _etiqueta(bool ok) {
    final color = ok ? AppTheme.verde : AppTheme.rojo;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(ok ? 'Aprobado' : 'Desaprobado',
          style: TextStyle(fontSize: 12, color: color)),
    );
  }
}

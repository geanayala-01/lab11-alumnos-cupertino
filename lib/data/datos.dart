import 'package:flutter/cupertino.dart';

/// Usuario que inicia sesión (un Map con sus datos de perfil).
/// Credenciales de prueba: maria.gonzalez@correo.com / 123456
final Map<String, String> usuario = {
  'nombre': 'María González',
  'email': 'maria.gonzalez@correo.com',
  'password': '123456',
  'telefono': '912345678',
  'rol': 'Docente',
};

/// Lista de alumnos: List de Maps.
/// Está dentro de un ValueNotifier: cuando se cambia la lista, todas las
/// pantallas que la escuchan (ValueListenableBuilder) se redibujan solas,
/// sin tener que pasar callbacks entre rutas.
final ValueNotifier<List<Map<String, dynamic>>> alumnos = ValueNotifier([
  {'nombre': 'Ana', 'apellido': 'Torres', 'nota': 18},
  {'nombre': 'Luis', 'apellido': 'García', 'nota': 12},
  {'nombre': 'María', 'apellido': 'López', 'nota': 9},
  {'nombre': 'Carlos', 'apellido': 'Ruiz', 'nota': 15},
  {'nombre': 'Sofía', 'apellido': 'Ramírez', 'nota': 16},
  {'nombre': 'Diego', 'apellido': 'Fernández', 'nota': 7},
]);

/// En el sistema vigesimal la nota mínima aprobatoria es 11 (10.5 redondeado).
bool aprobado(Map<String, dynamic> a) => (a['nota'] as int) >= 11;

String nombreCompleto(Map<String, dynamic> a) => '${a['nombre']} ${a['apellido']}';

/// Muestra la nota siempre con dos dígitos (9 -> "09"), como en el diseño.
String notaTexto(Map<String, dynamic> a) => '${a['nota']}'.padLeft(2, '0');

/// Se crea una lista NUEVA en cada cambio para que el ValueNotifier
/// detecte el cambio (si solo se modifica la misma lista, no avisa).
void agregarAlumno(Map<String, dynamic> a) => alumnos.value = [...alumnos.value, a];

void reemplazarAlumno(Map<String, dynamic> viejo, Map<String, dynamic> nuevo) =>
    alumnos.value = alumnos.value.map((a) => identical(a, viejo) ? nuevo : a).toList();

void eliminarAlumno(Map<String, dynamic> a) =>
    alumnos.value = alumnos.value.where((x) => !identical(x, a)).toList();

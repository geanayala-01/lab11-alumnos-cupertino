import 'package:flutter_test/flutter_test.dart';
import 'package:lab11/data/datos.dart';

void main() {
  test('Aprobado desde 11, nota con dos dígitos', () {
    expect(aprobado({'nota': 11}), isTrue);
    expect(aprobado({'nota': 10}), isFalse);
    expect(notaTexto({'nota': 9}), '09');
  });

  test('Agregar, editar y eliminar alumnos', () {
    final inicial = alumnos.value.length;
    final a = {'nombre': 'Test', 'apellido': 'Uno', 'nota': 14};
    agregarAlumno(a);
    expect(alumnos.value.length, inicial + 1);
    final b = {'nombre': 'Test', 'apellido': 'Uno', 'nota': 8};
    reemplazarAlumno(a, b);
    expect(alumnos.value.last['nota'], 8);
    eliminarAlumno(b);
    expect(alumnos.value.length, inicial);
  });
}

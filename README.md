# Lab S11-S12 – Sección A: Alumnos con Cupertino (Flutter)

Mismo laboratorio de la semana 8 (Sección A), hecho con widgets **Cupertino** (diseño iOS).

Usuario de prueba: `maria.gonzalez@correo.com` / `123456`

## Pantallas y rutas
| Ruta | Pantalla |
|---|---|
| `/login` | 1. Login (valida email y contraseña) |
| `/menu` | 2. Menú (Registrar, Listar, Perfil, Logout) |
| `/alumnos` | 3. Listar alumnos (buscador, filtro, Aprobado / Desaprobado) |
| `/registrar` | 4. Registrar alumno (también edita si recibe un alumno como argumento) |
| `/perfil` | 5. Perfil (con editar perfil) |

## Temas aplicados
| Tema | Dónde |
|---|---|
| ListViews | `ListView` en todas las pantallas, `ListView.builder` en la lista de alumnos |
| ListTiles | `CupertinoListTile` dentro de `CupertinoListSection` (menú, perfil, alumnos) |
| Listas y Mapas | `data/datos.dart`: alumnos como `List<Map>`, usuario como `Map`, opciones del menú |
| Rutas | Rutas con nombre en `CupertinoApp`, `pushReplacementNamed`, `pushNamedAndRemoveUntil`, argumentos |
| Tema global | `theme/app_theme.dart` con `CupertinoThemeData` (color morado) |
| Cards | Tarjetas de alumnos y resumen del menú (`AppTheme.tarjeta`) |

## Widgets Cupertino usados
`CupertinoApp`, `CupertinoPageScaffold`, `CupertinoNavigationBar`, `CupertinoNavigationBarBackButton`,
`CupertinoTextField`, `CupertinoSearchTextField`, `CupertinoButton` / `.filled`, `CupertinoListSection`,
`CupertinoListTile`, `CupertinoSlidingSegmentedControl`, `CupertinoActionSheet`, `CupertinoAlertDialog`,
`showCupertinoModalPopup`, `CupertinoActivityIndicator`, `CupertinoIcons`.

## Ejecutar
```bash
flutter pub get
flutter run
```

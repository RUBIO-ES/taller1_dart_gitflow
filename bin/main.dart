import 'dart:io';

void main() {
  // Lista principal que almacenará cada producto representado como un Mapa
  List<Map<String, dynamic>> catalogo = [];

  bool ejecutando = true;

  while (ejecutando) {
    print('  GESTIÓN DE CATÁLOGO DE PRODUCTOS  ');
    print('1. Agregar producto');
    print('2. Listar productos');
    print('3. Actualizar producto');
    print('4. Eliminar producto');
    print('5. Salir');
    print('------------------------------------');
    stdout.write('Seleccione una opción (1-5): ');

    String? opcionInput = stdin.readLineSync();

    switch (opcionInput) {
      case '1':
        agregarProducto(catalogo);
        break;
      case '2':
        listarProductos(catalogo);
        break;
      case '3':
        actualizarProducto(catalogo);
        break;
      case '4':
        eliminarProducto(catalogo);
        break;
      case '5':
        print('\n¡Gracias por usar el sistema! Hasta luego.');
        ejecutando = false;
        break;
      default:
        print('\n[Error] Opción no válida. Intente nuevamente.');
    }
  }
}

// FUNCIONES DEL SISTEMA CRUD
/// 1. AGREGAR PRODUCTO
void agregarProducto(List<Map<String, dynamic>> catalogo) {
  print('\n--- Agregar Nuevo Producto ---');

  // Nombre
  String nombre = '';
  while (nombre.isEmpty) {
    stdout.write('Nombre del producto: ');
    nombre = stdin.readLineSync()?.trim() ?? '';
    if (nombre.isEmpty) {
      print('[Error] El nombre no puede estar vacío.');
    }
  }

  // Precio
  double? precio;
  while (precio == null || precio <= 0) {
    stdout.write('Precio: ');
    String? input = stdin.readLineSync();
    precio = double.tryParse(input ?? '');
    if (precio == null || precio <= 0) {
      print('[Error] Ingrese un precio numérico válido y mayor a 0.');
    }
  }

  // Cantidad
  int? cantidad;
  while (cantidad == null || cantidad < 0) {
    stdout.write('Cantidad disponible: ');
    String? input = stdin.readLineSync();
    cantidad = int.tryParse(input ?? '');
    if (cantidad == null || cantidad < 0) {
      print('[Error] Ingrese una cantidad entera válida (>= 0).');
    }
  }


  // Crear mapa del producto y agregar a la lista

  Map<String, dynamic> nuevoProducto = {
    'nombre': nombre,
    'precio': precio,
    'cantidad': cantidad,
  };

  catalogo.add(nuevoProducto);
  print('\n[éxito] Producto "$nombre" agregado correctamente.');
}

/// 2. LISTAR PRODUCTOS
void listarProductos(List<Map<String, dynamic>> catalogo) {
  print('\n--- Lista de Productos ---');

  if (catalogo.isEmpty) {
    print('El catálogo está vacío actualmente.');
    return;
  }

  print('Índice | Nombre              | Precio       | Cantidad');

  for (int i = 0; i < catalogo.length; i++) {
    var prod = catalogo[i];
    String indiceStr = (i + 1).toString().padRight(6);
    String nombreStr = prod['nombre'].toString().padRight(19);
    String precioStr = '\$${prod['precio'].toStringAsFixed(2)}'.padRight(12);
    String cantidadStr = prod['cantidad'].toString();

    print('$indiceStr| $nombreStr| $precioStr| $cantidadStr');
  }
  print('------------------------------------------------------------');
}

/// 3. ACTUALIZAR PRODUCTO


void actualizarProducto(List<Map<String, dynamic>> catalogo) {
  print('\n--- Actualizar Producto ---');

  if (catalogo.isEmpty) {
    print('El catálogo está vacío. No hay productos para actualizar.');
    return;
  }

  listarProductos(catalogo);

  stdout.write('\nIngrese el número del producto a actualizar (1 - ${catalogo.length}): ');
  String? inputIndice = stdin.readLineSync();
  int? indice = int.tryParse(inputIndice ?? '');

  if (indice == null || indice < 1 || indice > catalogo.length) {
    print('[Error] Número de producto inválido.');
    return;
  }

  // Ajustar el índice para base cero
  int posicion = indice - 1;
  var producto = catalogo[posicion];

  print('\nDeje la entrada en blanco si desea conservar el valor actual.\n');

  // Actualizar Nombre
  stdout.write('Nuevo nombre [Actual: ${producto['nombre']}]: ');
  String nuevoNombre = stdin.readLineSync()?.trim() ?? '';
  if (nuevoNombre.isNotEmpty) {
    producto['nombre'] = nuevoNombre;
  }

  // Actualizar Precio
  stdout.write('Nuevo precio [Actual: \$${producto['precio']}]: ');
  String inputPrecio = stdin.readLineSync()?.trim() ?? '';
  if (inputPrecio.isNotEmpty) {
    double? nuevoPrecio = double.tryParse(inputPrecio);
    if (nuevoPrecio != null && nuevoPrecio > 0) {
      producto['precio'] = nuevoPrecio;
    } else {
      print('[Aviso] Precio inválido. Se conserva el valor anterior.');
    }
  }

  // Actualizar Cantidad
  stdout.write('Nueva cantidad [Actual: ${producto['cantidad']}]: ');
  String inputCantidad = stdin.readLineSync()?.trim() ?? '';
  if (inputCantidad.isNotEmpty) {
    int? nuevaCantidad = int.tryParse(inputCantidad);
    if (nuevaCantidad != null && nuevaCantidad >= 0) {
      producto['cantidad'] = nuevaCantidad;
    } else {
      print('[Aviso] Cantidad inválida. Se conserva el valor anterior.');
    }
  }

  print('\n[éxito] Producto actualizado correctamente.');
}
/// 4. ELIMINAR PRODUCTO

void eliminarProducto(List<Map<String, dynamic>> catalogo) {
  print('\n--- Eliminar Producto ---');

  if (catalogo.isEmpty) {
    print('El catálogo está vacío. No hay productos para eliminar.');
    return;
  }

  listarProductos(catalogo);

  stdout.write('\nIngrese el número del producto a eliminar (1 - ${catalogo.length}): ');
  String? inputIndice = stdin.readLineSync();
  int? indice = int.tryParse(inputIndice ?? '');

  if (indice == null || indice < 1 || indice > catalogo.length) {
    print('[Error] Número de producto inválido.');
    return;
  }

  int posicion = indice - 1;
  String nombreEliminado = catalogo[posicion]['nombre'];

  catalogo.removeAt(posicion);
  print('\n[éxito] El producto "$nombreEliminado" fue eliminado del catálogo.');
}
import 'dart:convert';

import '../models/column_get_model.dart';

int parseDynamicToInt(dynamic value) {
  if (value == null) {
    throw ArgumentError('El valor no puede ser nulo para int');
  }
  
  if (value is int) {
    return value;
  }
  
  if (value is String) {
    final parsed = int.tryParse(value);
    if (parsed == null) {
      throw FormatException('El string "$value" no es un entero válido');
    }
    return parsed;
  }
  
  if (value is num) {
    return value.toInt();
  }
  
  throw FormatException('Tipo no soportado para conversión a int: ${value.runtimeType}');
}

String parseDynamicToString(dynamic value) {
  if (value == null) {
    throw ArgumentError('El valor no puede ser nulo para String');
  }
  
  if (value is String) {
    return value;
  }
  
  if (value is num || value is bool) {
    return value.toString();
  }
  
  throw FormatException('Tipo no soportado para conversión a String: ${value.runtimeType}');
}

Map<String, dynamic> parseDynamicToMap(dynamic value) {
  if (value == null) {
    throw ArgumentError('El valor no puede ser nulo para Map');
  }
  
  if (value is Map<String, dynamic>) {
    return value;
  }
  
  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }
  
  throw FormatException('Tipo no soportado para conversión a Map: ${value.runtimeType}');
}

List<ColumnGetModel> parseColumnsList(dynamic columnsJson) {
  try {
    // Decodificar el JSON y verificar que sea una lista
    final decoded = json.decode(columnsJson is String ? columnsJson : json.encode(columnsJson));
    
    if (decoded is! List) {
      throw FormatException('El formato de columnas no es un array válido');
    }

    // Convertir cada elemento del array
    return decoded.map((item) {
      if (item is! Map<String, dynamic>) {
        throw FormatException('Cada elemento de columnas debe ser un objeto');
      }
      return ColumnGetModel.fromMap(item);
    }).toList();
  } catch (e, stackTrace) {
    throw FormatException('Error al parsear las columnas: $e', stackTrace);
  }
}
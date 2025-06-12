import 'package:geobase/src/domain/entities/field_type_get_entity.dart';
import 'package:geobase/src/domain/entities/column_get_entity.dart';

class FieldTypeFormGetEntity extends FieldTypeGetEntity {
  FieldTypeFormGetEntity({
    required super.name,
    required super.metaType,
    required super.id,
    required super.renderClass,
    required this.columns,
  });

  factory FieldTypeFormGetEntity.fromMap(Map<String, dynamic> map) {
    try {
      if (map['extradata'] != null) {
        return FieldTypeFormGetEntity(
          name: map['name'].toString(), // Manejo de nulos
          metaType: map['metaType']?.toString() ?? 'Form', // Valor por defecto
          id: (map['id'] as int).toInt(), // Conversión segura de números
          renderClass: map['renderClass'].toString(),
          columns: (map['extradata']['columns'] as List<dynamic>?)
                  ?.map((columnMap) => ColumnGetEntity.fromMap(
                      columnMap as Map<String, dynamic>))
                  .toList() ??
              [], // Lista vacía por defecto
        );
      } else {
        return FieldTypeFormGetEntity(
          name: map['name'].toString(), // Manejo de nulos
          metaType: map['metaType']?.toString() ?? 'Form', // Valor por defecto
          id: (map['id'] as int).toInt(), // Conversión segura de números
          renderClass: map['renderClass'].toString(),
          columns: (map['columns'] as List<dynamic>?)
                  ?.map((columnMap) => ColumnGetEntity.fromMap(
                      columnMap as Map<String, dynamic>))
                  .toList() ??
              [], // Lista vacía por defecto
        );
      }
    } catch (e) {
      throw FormatException(
          'Failed to parse FieldTypeFormGetEntity (${map['name']}): $e');
    }
  }

  final List<ColumnGetEntity> columns;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'columns': columns.map((column) => column.toMap()).toList(),
    };
  }
}

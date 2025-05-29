import 'package:geobase/src/domain/entities/field_value_entity.dart';

class FieldValuePostEntity extends FieldValueEntity {

  FieldValuePostEntity({
    required super.value,
    this.geodataId,
    required this.columnId,
  });

  final int? geodataId;
  final int columnId;

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'geodataId': geodataId,
      'columnId': columnId,
    };
  }

  @override
  FieldValueEntity copyWithValue(dynamic value) {
    return FieldValuePostEntity(
      value: value,
      columnId: columnId,
      geodataId: geodataId,
    );
  }
}
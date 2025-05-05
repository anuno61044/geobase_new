import 'package:geobase/src/infrastructure/models/column_model.dart';
import 'package:geobase/src/infrastructure/models/field_type_get_model.dart';
import 'package:geobase/src/infrastructure/utils/parsing_helpers.dart';

class ColumnGetModel extends ColumnModel {
  ColumnGetModel({
    required this.id,
    this.categoryId,
    required super.name,
    required this.type,

  });

  final int id;

  final int? categoryId;

  final FieldTypeGetModel type;

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'type': type,
    };
  }

  // Método factory para crear desde Map
  factory ColumnGetModel.fromMap(Map<String, dynamic> map) {
    return ColumnGetModel(
      id: parseDynamicToInt(map['id']),
      categoryId: parseDynamicToInt(map['categoryId']),
      name: parseDynamicToString(map['name']),
      type: FieldTypeGetModel.fromMap(parseDynamicToMap(map['type'])),
    );
  }
}

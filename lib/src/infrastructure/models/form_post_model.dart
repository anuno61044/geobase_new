import 'dart:convert';

import 'package:geobase/src/infrastructure/models/column_post_model.dart';
import 'package:geobase/src/infrastructure/models/field_type_get_model.dart';

class FieldTypeFormPostModel extends FieldTypeModel {
  FieldTypeFormPostModel({
    required super.name,
    required super.metaType,
    this.renderClass,
    required this.columns,
  });

  ///Used to generate new built-in complex of this kind (in compilation time)
  final String? renderClass;

  final List<ColumnPostModel> columns;

  // Serializar todas las columnas a List<Map>
  List<Map<String, dynamic>> columnsToMapList() {
    return columns.map((column) => column.toMap()).toList();
  }

  // Serializar todas las columnas a JSON String
  String columnsToJson() {
    return json.encode(columnsToMapList());
  }
}

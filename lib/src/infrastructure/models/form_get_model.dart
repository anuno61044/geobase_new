import 'package:geobase/src/infrastructure/models/field_type_get_model.dart';
import 'package:geobase/src/infrastructure/models/column_get_model.dart';

class FieldTypeFormGetModel extends FieldTypeGetModel {
  FieldTypeFormGetModel({
    required super.name,
    required super.metaType,
    required super.id,
    required super.renderClass,
    required this.columns,
  });

  final List<ColumnGetModel> columns;
}

import 'package:geobase/src/infrastructure/models/column_model.dart';
import 'package:geobase/src/infrastructure/models/field_type_get_model.dart';

class ColumnGetModel extends ColumnModel {
  ColumnGetModel({
    required this.id,
    this.categoryId,
    required super.name,
    required this.type,
    this.formId,

  });

  final int id;

  final int? categoryId;

  final FieldTypeGetModel type;

  final int? formId;
}

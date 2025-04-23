import 'package:geobase/src/infrastructure/models/column_model.dart';

class ColumnPutModel extends ColumnModel {
  ColumnPutModel({
    required this.id,
    this.categoryId,
    required this.typeId,
    required super.name,
    this.formId,
  });

  final int id;

  final int? categoryId;

  final int typeId;

  final int? formId;
}

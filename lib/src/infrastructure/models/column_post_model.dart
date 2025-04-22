import 'package:geobase/src/infrastructure/models/column_model.dart';

class ColumnPostModel extends ColumnModel {
  ColumnPostModel({
    required super.name,
    this.categoryId,
    required this.typeId,
    this.formId,
  });

  final int? categoryId;

  final int typeId;

  final int? formId;
}

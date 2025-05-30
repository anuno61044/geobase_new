import 'package:geobase/src/domain/entities/column_entity.dart';

class ColumnPostEntity extends ColumnEntity {
  ColumnPostEntity({
    required super.name,
    this.categoryId,
    required this.typeId,
    this.formId,
  });

  final int? categoryId;

  final int typeId;

  final int? formId;
}

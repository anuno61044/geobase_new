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

  final List<ColumnGetEntity> columns;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'columns': columns.map((column) => column.toJson()).toList(),
    };
  }
}

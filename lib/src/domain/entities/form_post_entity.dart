import 'package:geobase/src/domain/entities/field_type_get_entity.dart';
import 'package:geobase/src/infrastructure/providers/providers.dart';
import 'package:geobase/src/domain/entities/column_post_entity.dart';

class FieldTypeFormPostEntity extends FieldTypeEntity {
  FieldTypeFormPostEntity({
    required super.name,
    required this.columns,
  }) : super(metaType: FORM_METATYPE_NAME);

  final List<ColumnPostEntity> columns;
}

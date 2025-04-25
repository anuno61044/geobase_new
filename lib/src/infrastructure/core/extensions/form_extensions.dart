import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/infrastructure/core/extensions/extensions.dart';
import 'package:geobase/src/infrastructure/models/models.dart';

extension FormGetModelExtension on FieldTypeFormGetModel {
  FieldTypeFormGetEntity toEntity() {
    return FieldTypeFormGetEntity(
      id: id,
      name: name,
      metaType: metaType,
      renderClass: renderClass,
      columns: columns.map((e) => e.toEntity()).toList(),
    );
  }
}

extension FormPostEntityExtension on FieldTypeFormPostEntity {
  FieldTypeFormPostModel toModel() {
    return FieldTypeFormPostModel(
      name: name,
      metaType: metaType,
      columns: columns.map((e) => e.toModel()).toList(),
    );
  }
}

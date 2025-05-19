import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/infrastructure/core/extensions/extensions.dart';
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

  FieldTypeGetModel type;

  final int? formId;

  ColumnGetEntity toEntity() {
    return ColumnGetEntity(
      id: id,
      categoryId: categoryId,
      name: name,
      type: type.toEntity(),
      formId: formId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': super.name,
      'id': id,
      if (categoryId != null) 'categoryId': categoryId,
      'type': type.toMap(),
      if (formId != null) 'formId': formId,
    };
  }
}

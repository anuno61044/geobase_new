import 'dart:convert';

import 'package:geobase/src/domain/entities/field_type_get_entity.dart';
import 'package:geobase/src/infrastructure/providers/providers.dart';

class FieldTypeStaticSelectionPostEntity extends FieldTypeEntity {
  factory FieldTypeStaticSelectionPostEntity.fromMap(Map<String, dynamic> map) {
    final rawOptions = map['options'];
    List<String> optionsList = [];

    if (rawOptions is String) {
      try {
        final decoded = jsonDecode(rawOptions);
        if (decoded is List) {
          optionsList = decoded.map((e) => e.toString()).toList();
        }
      } catch (e) {
        // manejar error de parseo si deseas
      }
    } else if (rawOptions is List) {
      optionsList = rawOptions.map((e) => e.toString()).toList();
    }

    return FieldTypeStaticSelectionPostEntity(
      name: map['name'] as String,
      options: optionsList,
    );
  }

  FieldTypeStaticSelectionPostEntity({
    required super.name,
    required this.options,
  }) : super(metaType: STATICSELECTION_METATYPE_NAME);

  final List<String> options;
}

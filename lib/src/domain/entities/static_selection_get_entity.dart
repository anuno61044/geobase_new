import 'package:geobase/src/domain/entities/field_type_get_entity.dart';
import 'dart:convert';

class FieldTypeStaticSelectionGetEntity extends FieldTypeGetEntity {
  FieldTypeStaticSelectionGetEntity({
    required super.name,
    required super.metaType,
    required super.id,
    required super.renderClass,
    required this.options,
  });

  factory FieldTypeStaticSelectionGetEntity.fromMap(Map<String, dynamic> map) {
    try {
      if (map['extradata'] != null) {
        return FieldTypeStaticSelectionGetEntity(
          name: map['name'] as String,
          metaType: map['metaType'] as String,
          id: map['id'] as int,
          renderClass: map['renderClass'] as String,
          options: parseOptions(map['extradata']['options'] as String),
        );
      } else {
        return FieldTypeStaticSelectionGetEntity(
          name: map['name'] as String,
          metaType: map['metaType'] as String,
          id: map['id'] as int,
          renderClass: map['renderClass'] as String,
          options: (map['options'] as List<dynamic>).map((e) => e.toString()).toList(),
        );
      }
    } catch (e) {
      throw FormatException(
          'Failed to parse FieldTypeStaticSelectionGetEntity: $e');
    }
  }

  final List<String> options;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'options': options,
    };
  }
}

List<String> parseOptions(String jsonString) {
  try {
    List<dynamic> parsed = jsonDecode(jsonString) as List<dynamic>;
    return parsed.cast<String>().map((e) => e.trim()).toList();
  } catch (e) {
    print('Error parsing options: $e');
    return [];
  }
}

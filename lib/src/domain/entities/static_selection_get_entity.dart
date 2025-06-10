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
      return FieldTypeStaticSelectionGetEntity(
        name: map['name'] as String,
        metaType: map['metaType'] as String,
        id: map['id'] as int,
        renderClass: map['renderClass'] as String,
        options: parseOptions(map['extradata']['options'] as String),
      );
    } catch (e) {
      throw FormatException('Failed to parse FieldTypeStaticSelectionGetEntity: $e');
    }
  }

  final List<String> options;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
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
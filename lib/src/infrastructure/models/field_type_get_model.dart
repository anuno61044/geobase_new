///Base Class for TypeModel.

import 'package:geobase/src/infrastructure/utils/parsing_helpers.dart';

abstract class FieldTypeModel {
  FieldTypeModel({
    required this.name,
    required this.metaType,
  });

  final String name;

  final String metaType;
}

class FieldTypeGetModel extends FieldTypeModel {
  FieldTypeGetModel({
    required super.name,
    required super.metaType,
    required this.renderClass,
    required this.id,
    this.extradata,
  });

  final int id;

  final String renderClass;

  final Map<String, dynamic>? extradata;

  factory FieldTypeGetModel.fromMap(Map<String, dynamic> map) {
    return FieldTypeGetModel(
      id: parseDynamicToInt((map['id'])),
      name: parseDynamicToString(map['name']),
      metaType: parseDynamicToString(map['metaType']),
      renderClass: parseDynamicToString(map['renderClass']),
      extradata: map['extradata'] != null 
          ? parseDynamicToMap(map['extradata'])
          : null,
    );
  }
}

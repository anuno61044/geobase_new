import 'dart:convert';

import 'package:geobase/src/infrastructure/models/column_model.dart';

class ColumnPostModel extends ColumnModel {
  ColumnPostModel({
    required super.name,
    this.categoryId,
    required this.typeId,
  });

  final int? categoryId;

  final int typeId;

  // Convertir a Map (serialización básica)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'categoryId': categoryId,
      'typeId': typeId,
    };
  }

  // Convertir a JSON String
  String toJson() => json.encode(toMap());

}

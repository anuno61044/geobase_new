import 'package:geobase/src/domain/entities/column_entity.dart';
import 'package:geobase/src/domain/entities/field_type_get_entity.dart';

class ColumnGetEntity extends ColumnEntity {
  ColumnGetEntity({
    required this.id,
    this.categoryId,
    required super.name,
    required this.type,
    this.formId,
  });

  final int id;

  final int? categoryId;

  final FieldTypeGetEntity type;

  final int? formId;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'type': type.toJson(),
    };
  }

  ColumnGetEntity copyWith({
    int? id,
    int? categoryId,
    String? name,
    FieldTypeGetEntity? type,
  }) {
    return ColumnGetEntity(
      name: name ?? this.name,
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColumnGetEntity &&
        other.id == id &&
        other.categoryId == categoryId &&
        other.name == name &&
        other.type == type;
  }

  @override
  int get hashCode =>
      id.hashCode ^ categoryId.hashCode ^ type.hashCode ^ name.hashCode;
}

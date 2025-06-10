import 'package:geobase/src/domain/entities/category_entity.dart';
import 'package:geobase/src/domain/entities/column_get_entity.dart';

class CategoryGetEntity extends CategoryEntity {

  factory CategoryGetEntity.fromMap(Map<String, dynamic> map) {
    try {
      return CategoryGetEntity(
        id: (map['id'] as num).toInt(),
        name: map['name']?.toString() ?? '',
        description: map['description']?.toString() ?? '',
        color: (map['color'] as num?)?.toInt() ?? 0,
        icon: map['icon']?.toString() ?? '',
        columns: (map['columns'] as List<dynamic>?)
                ?.map((columnMap) =>
                    ColumnGetEntity.fromMap(columnMap as Map<String, dynamic>))
                .toList() ??
            [],
      );
    } catch (e) {
      throw FormatException('Failed to parse CategoryGetEntity: $e');
    }
  }
  CategoryGetEntity({
    required this.id,
    required super.name,
    required super.description,
    required super.color,
    required super.icon,
    required this.columns,
  });

  final int id;

  final List<ColumnGetEntity> columns;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(), // Incluye los campos de CategoryEntity
      'id': id,
      'columns': columns.map((e) => e.toJson()).toList(),
    };
  }
}

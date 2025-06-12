abstract class CategoryEntity {
  CategoryEntity({
    required this.name,
    this.description,
    this.color,
    required this.icon,
  });

  final String name;

  final String? description;

  final int? color;

  final String icon;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'color': color,
      'icon': icon,
    };
  }
}

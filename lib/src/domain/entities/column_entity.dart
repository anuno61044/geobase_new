abstract class ColumnEntity {
  ColumnEntity({
    required this.name,
  });

  final String name;

  Map<String, dynamic> toJson() {
    return {
      'name': name
    };
  }
}

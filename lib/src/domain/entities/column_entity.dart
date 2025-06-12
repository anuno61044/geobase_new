abstract class ColumnEntity {
  ColumnEntity({
    required this.name,
  });

  final String name;

  Map<String, dynamic> toMap() {
    return {
      'name': name
    };
  }
}

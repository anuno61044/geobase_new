///Base Class for TypeModel.
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

  Map<String, dynamic>? extradata;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'metaType': metaType,
      'renderClass': renderClass,
      if (extradata != null) 'extradata': extradata,
    };
  }
}

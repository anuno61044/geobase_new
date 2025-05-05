import 'dart:convert';
import 'dart:developer';

import 'package:geobase/injection.dart';
import 'package:geobase/src/infrastructure/models/models.dart';
import 'package:geobase/src/infrastructure/providers/providers.dart';
import 'package:geobase/src/infrastructure/utils/parsing_helpers.dart';

@LazySingleton(as: IFieldTypeFormProvider)
class FormSQLiteProvider implements IFieldTypeFormProvider {
  @override
  Future<int> create(FieldTypeFormPostModel model) async {
    final fieldTypeId = await FieldTypeDBModel.withFields(
      model.name,
      model.metaType,
      model.renderClass ?? FORM_RENDER_CLASS,
    ).save();
    if (fieldTypeId == null) throw Exception('Create FieldType Form Denied');
    try {
      final id = await FormDBModel.withFields(
        model.name,
        fieldTypeId,
        model.columnsToJson()
      ).save();
      if (id == null) throw Exception('Create Form Denied');
      return id;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FieldTypeFormGetModel>> getAll() async {
    final formdb = await FormDBModel().select().toList();
    final result = <FieldTypeFormGetModel>[];
    for (final form in formdb) {
      final fieldType = await form.getFieldTypeDBModel();
      result.add(
        FieldTypeFormGetModel(
          name: fieldType!.name!,
          metaType: fieldType.meta_type!,
          id: form.field_type_id!,
          renderClass: fieldType.render_class!,
          columns: parseColumnsList(form.columns!),
        ),
      );
    }

    return result;
  }

  @override
  Future<FieldTypeFormGetModel> getByFieldTypeId(int id) async {
    final form = await FormDBModel()
        .select()
        .field_type_id
        .equals(id)
        .toSingle(preload: true);
    if (form == null) throw Exception('Form Not Found');
    try {
      return FieldTypeFormGetModel(
        id: form.field_type_id!,
        name: form.name!,
        metaType: form.plFieldTypeDBModel!.meta_type!,
        renderClass: form.plFieldTypeDBModel!.render_class!,
        columns: parseColumnsList(form.columns!),
      );
    } catch (e) {
      throw Exception('Error al procesar el formulario: $e');
    }
  }

  @override
  Future<void> remove(int id) async {
    final result = await FormDBModel()
      .select()
      .field_type_id
      .equals(id)
      .delete();
    if (result.errorMessage?.isNotEmpty ?? false) {
      throw Exception(result.errorMessage);
    }
  }
}

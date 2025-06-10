import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geobase/injection.dart';
import 'package:geobase/src/domain/entities/entities.dart';
import 'package:geobase/src/domain/services/services.dart';
import 'package:geobase/src/presentation/pages/categories/blocs/categories_importer/categories_importer_state.dart';

@injectable
class CategoriesImporterCubit extends Cubit<CategoriesImporterState> {
  CategoriesImporterCubit() : super(const CategoriesImporterState());

  Future<void> importFromJson() async {
    emit(state.copyWith(status: CategoryImporterStatus.loading, message: null));

    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Selecciona el archivo de categorías',
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.single.path == null) {
        emit(state.copyWith(
          status: CategoryImporterStatus.error,
          message: 'No se seleccionó ningún archivo.',
        ));
        return;
      }

      // Obtención del json con las categorias serializadas
      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      final jsonData = jsonDecode(content) as Map<String, dynamic>;

      // Por cada metatype (Form o Seleccion Estatica) retorna una lista con todos los nombres en el json
      final Map<String, List<String>> typeNames =
          extractTypedNamesFromJson(jsonData);

      // Servicios necesarios para crear y obtener las entidades
      final ICategoryService categoryService = getIt<ICategoryService>();
      final IFieldTypeFormService formService = getIt<IFieldTypeFormService>();
      final IFieldTypeStaticSelectionService staticselectionService =
          getIt<IFieldTypeStaticSelectionService>();

      // Cargar formularios y selecciones existentes desde la base de datos
      final formsResult = await formService.loadAll();
      final selectionsResult = await staticselectionService.loadAll();
      final existingForms = formsResult.getOrElse(() => []);
      final existingSelections = selectionsResult.getOrElse(() => []);

      // Revisar si las entidades que se van a crear ya existen con esos nombres
      if (existsInEntities<FieldTypeFormGetEntity>(existingForms, typeNames,
              'Form', (form) => typeNames['Form']!.contains(form.name)) ||
          existsInEntities<FieldTypeStaticSelectionGetEntity>(
              existingSelections,
              typeNames,
              'StaticSelection',
              (selection) =>
                  typeNames['StaticSelection']!.contains(selection.name))) {
        emit(state.copyWith(
          status: CategoryImporterStatus.error,
          message: 'Existen tipos con los mismos nombres a importar.',
        ));
        return;
      }

      final rawCategories = jsonData['categories'] ?? [];
      List<CategoryGetEntity> categories = [];

      for (Map<String, dynamic> category in rawCategories) {
        categories.add(CategoryGetEntity.fromMap(category));
      }

      // Recorrer las categorias buscando formularios o selecciones estaticas y guardarlas en la base de datos
      await saveFieldTypesByCategories(categories);

      emit(state.copyWith(
        status: CategoryImporterStatus.success,
        message: 'Categorías importadas con éxito',
      ));

    } catch (e) {
      emit(state.copyWith(
        status: CategoryImporterStatus.error,
        message: 'Error al importar categorías: ${e.toString()}',
      ));
      log('$e');
    }
  }

  Future<Map<String, int>> saveFieldTypesByCategories(
      List<CategoryGetEntity> categories) async {
    Map<String, int> result = {};

    for (final category in categories) {
      Map<String, int> newEntries =
          await saveFieldTypesByColumns(category.columns, result);
      result.addEntries(newEntries.entries);

      List<ColumnPostEntity> categoryColumns = [];
      for (final categoryColumn in category.columns) {
        if (result.containsKey(categoryColumn.type.name)) {
          categoryColumns.add(ColumnPostEntity(
              name: categoryColumn.name,
              typeId: result[categoryColumn.type.name]!));
        } else {
          categoryColumns.add(ColumnPostEntity(
              name: categoryColumn.name, typeId: categoryColumn.type.id));
        }
      }
      final responseDB = await getIt<ICategoryService>().createCategory(
          CategoryPostEntity(
              name: category.name,
              description: category.description,
              color: category.color,
              icon: category.icon,
              columns: categoryColumns));
      responseDB.fold(
          (error) => emit(state.copyWith(
                status: CategoryImporterStatus.error,
                message:
                    'Error al cargar categorías por problemas en el archivo',
              )),
          (id) => null);
    }

    return result;
  }

  Future<Map<String, int>> saveFieldTypesByColumns(
      List<ColumnGetEntity> columns, Map<String, int> fieldTypesCreated) async {
    Map<String, int> result = {};

    for (final column in columns) {
      if (column.type is FieldTypeFormGetEntity) {
        FieldTypeFormGetEntity form = column.type as FieldTypeFormGetEntity;
        Map<String, int> newEntries =
            await saveFieldTypesByColumns(form.columns, result);
        result.addEntries(newEntries.entries);

        List<ColumnPostEntity> formColumns = [];
        for (final formColumn in form.columns) {
          if (result.containsKey(formColumn.type.name)) {
            formColumns.add(ColumnPostEntity(
                name: formColumn.name, typeId: result[formColumn.type.name]!));
          } else {
            formColumns.add(ColumnPostEntity(
                name: formColumn.name, typeId: formColumn.type.id));
          }
        }
        final responseDB = await getIt<IFieldTypeFormService>()
            .createForm(FieldTypeFormPostEntity(
          name: form.name,
          columns: formColumns,
        ));
        responseDB.fold(
            (error) => emit(state.copyWith(
                  status: CategoryImporterStatus.error,
                  message:
                      'Error al cargar categorías por problemas en el archivo',
                )),
            (id) => result[form.name] = id);
      } else if (column.type is FieldTypeStaticSelectionGetEntity) {
        FieldTypeStaticSelectionGetEntity sel =
            column.type as FieldTypeStaticSelectionGetEntity;
        if (result.containsKey(sel.name)) continue;
        final responseDB = await getIt<IFieldTypeStaticSelectionService>()
            .createStaticSelection(FieldTypeStaticSelectionPostEntity(
          name: sel.name,
          options: sel.options,
        ));

        responseDB.fold(
            (error) => emit(state.copyWith(
                  status: CategoryImporterStatus.error,
                  message:
                      'Error al cargar categorías por problemas en el archivo',
                )),
            (id) => result[sel.name] = id);
      }
    }

    return result;
  }

  Map<String, List<String>> extractTypedNamesFromJson(
      Map<String, dynamic> json) {
    final Map<String, Set<String>> result = {};

    final categories = json['categories'] as List<dynamic>? ?? [];

    for (final category in categories) {
      final columns =
          (category as Map<String, dynamic>)['columns'] as List<dynamic>? ?? [];

      for (final column in columns) {
        final columnMap = column as Map<String, dynamic>;
        final type = columnMap['type'] as Map<String, dynamic>?;

        if (type != null) {
          final metaType = type['metatype'] as String?;
          final name = type['name'] as String?;

          if (metaType != null && name != null) {
            result.putIfAbsent(metaType, () => {}).add(name);
          }
        }
      }
    }

    // Convert Set to List before returning
    return result.map((key, value) => MapEntry(key, value.toList()));
  }

  bool existsInEntities<T>(
    List<T> existingEntities,
    Map<String, List<String>> extractedMap,
    String type,
    bool Function(T entity) predicate,
  ) {
    final namesToCheck = extractedMap[type] ?? [];

    for (final _ in namesToCheck) {
      final found = existingEntities.any((e) => predicate(e));
      if (found) return true;
    }

    return false;
  }
}

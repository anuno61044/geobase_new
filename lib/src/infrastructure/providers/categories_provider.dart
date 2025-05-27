import 'dart:developer';

import 'package:geobase/injection.dart';
import 'package:geobase/src/infrastructure/models/models.dart';
import 'package:geobase/src/infrastructure/providers/providers.dart';

@LazySingleton(as: ICategoriesProvider)
class CategoriesSQLiteProvider implements ICategoriesProvider {
  @override
  Future<int> create(CategoryPostModel model) async {
    try {
      final categoryId = await CategoryDBModel.withFields(
        model.name,
        model.description,
        model.color,
        model.icon,
      ).save();
      if (categoryId == null) throw Exception('Create Category Denied');
      for (final col in model.columns) {
        await getIt<IColumnsProvider>().create(
          ColumnPostModel(
            name: col.name,
            typeId: col.typeId,
            categoryId: categoryId,
          ),
        );
      }
      return categoryId;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> edit(CategoryPutModel model) async {
    try {
      final categoryId = await CategoryDBModel.withId(
        model.id,
        model.name,
        model.description,
        model.color,
        model.icon,
      ).save();
      if (categoryId == null) throw Exception('Edit Category Denied');
      for (final col in model.editedColumns) {
        await getIt<IColumnsProvider>().edit(col);
      }
      for (final id in model.removedColumns) {
        await getIt<IColumnsProvider>().remove(id);
      }
      for (final col in model.newColumns) {
        await getIt<IColumnsProvider>().create(col);
      }
      return categoryId;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoryGetModel>> getAll() async {
    final categories = await CategoryDBModel().select().toList();
    final result = <CategoryGetModel>[];

    for (var cat in categories) {
      // Obtenemos todas las columnas para todas las categorías en un solo mapa
      final columns =
          await getIt<IColumnsProvider>().getAllFromCategory(cat.category_id!);

      List<ColumnGetModel> columnsList = [];

      for (var col in columns) {
        columnsList.add(await _processColumnWithExtraData(col));
      }

      result.add(
        CategoryGetModel(
          id: cat.category_id!,
          name: cat.name!,
          description: cat.description,
          color: cat.color,
          icon: cat.icon!,
          columns: columnsList,
        ),
      );
    }
    return result;
  }

  @override
  Future<CategoryGetModel> getById(int id) async {
    final category =
        await CategoryDBModel().select().category_id.equals(id).toSingle();
    if (category == null) throw Exception('Category Not Found');

    List<ColumnGetModel> columns =
        await getIt<IColumnsProvider>().getAllFromCategory(id);
    List<ColumnGetModel> columnsList = [];

    for (var col in columns) {
      columnsList.add(await _processColumnWithExtraData(col));
    }
    return CategoryGetModel(
      id: category.category_id!,
      name: category.name!,
      description: category.description,
      icon: category.icon!,
      color: category.color,
      columns: columnsList,
    );
  }

  @override
  Future<void> remove(int id) async {
    final result =
        await CategoryDBModel().select().category_id.equals(id).delete();
    if (result.errorMessage?.isNotEmpty ?? false) {
      throw Exception(result.errorMessage);
    }
  }

  @override
  Future<List<CategoryGetModel>> getByNameSubstring(
    String nameSubstring,
  ) async {
    final categories = await CategoryDBModel()
        .select()
        .where("name LIKE '%$nameSubstring%'")
        //also: instr(column, 'cats') > 0
        .toList();
    //FIXME: REMOVE THESE LINES
    final r = await ColumnDBModel().select().toList();
    log(r.toString());
    final result = <CategoryGetModel>[];
    for (final cat in categories) {
      final columns =
          await getIt<IColumnsProvider>().getAllFromCategory(cat.category_id!);

      result.add(
        CategoryGetModel(
          id: cat.category_id!,
          name: cat.name!,
          description: cat.description,
          color: cat.color,
          icon: cat.icon!,
          columns: columns,
        ),
      );
    }
    return result;
  }

  // Método interno para procesar una columna y agregar datos de formulario si es necesario
  Future<ColumnGetModel> _processColumnWithExtraData(
      ColumnGetModel column) async {
    if (column.type.metaType == 'Form') {
      final associatedColumns =
          await getIt<IColumnsProvider>().getAllFromForm(column.type.id);

      List<Map<String, dynamic>> columns =
          associatedColumns.map((col) => col.toMap()).toList();

      final modifiedColumn = ColumnGetModel(
          id: column.id,
          name: column.name,
          type: FieldTypeGetModel(
            name: column.type.name,
            renderClass: column.type.renderClass,
            id: column.type.id,
            metaType: column.type.metaType,
            extradata: {...?column.type.extradata, 'columns': columns},
          ));
      return modifiedColumn;
    }
    return column;
  }
}
